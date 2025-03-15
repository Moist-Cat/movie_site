import os
import datetime
from functools import wraps
import json
from json.encoder import JSONEncoder
import re
import logging

from flask import Blueprint, Flask, request, make_response
from flask_classful import FlaskView, route
from flask_cors import CORS
from werkzeug.exceptions import HTTPException
import sqlalchemy
from sqlalchemy import and_, func, text, select

# required for fetching the trailer
from bs4 import BeautifulSoup
import requests

from movieapp.api import Client
from movieapp.db import Base, Movie, LinkLabel, TaggedMovie, Tag
from movieapp.conf import settings
from movieapp.log import logged

log = logging.getLogger("global")

app = Flask(__name__)
CORS(app)
api = Blueprint("api", __name__, url_prefix="/api")

STATIC_NETFLIX_LIST = {
    "Better Call Saul": 45,
    "Arcane: League of Legends": 40,
    "Black Mirror": 60,
    "Blue Eye Samurai": 45,
    "Strappare lungo i bordi": 22,
    "Monster": 24,
    "Questo mondo non mi renderà cattivo": 30,
    "The Crown": 60,
    "Ripley": 60,
    "World War II: From the Frontlines": 49,
    # "Dan Da Dan: First Encounter": 83, #not available
    "La sociedad de la nieve": 144,
    "Top Boy": 60,
    "Chef's Table": 50,
    "Derry Girls": 30,
    "Maid": 60,
    "Sex Education": 60,
    "Ozark": 60,
    "One Piece": 60,
    "Archer": 22,
    "The Remarkable Life of Ibelin": 106,
    "Fauda": 60,
    "Cobra Kai": 30,
    "Im Westen nichts Neues": 148,
    "Danjon meshi": 26,
    "The Gentlemen": 50,
}


class ModelSerializer(JSONEncoder):
    def default(self, o):
        if isinstance(o, Base):
            return o.as_dict()
        if isinstance(o, datetime.datetime):
            return o.strftime("%Y-%m-%d")
        return super().default(o)


encoder = ModelSerializer()

client = Client()

# REST API
def output_json(data, code, headers=None):
    content_type = "application/json"
    dumped = encoder.encode(data)
    if headers:
        headers.update({"Content-Type": content_type})
    else:
        headers = {"Content-Type": content_type}
    response = make_response(dumped, code, headers)
    return response


def protected(decorated):
    """
    Protect a method against db failure
    """

    @wraps(decorated)
    def internal(*args, **kwargs):
        try:
            res = decorated(*args, **kwargs)
            return res
        except (
            sqlalchemy.exc.ProgrammingError,
            sqlalchemy.exc.InternalError,
            sqlalchemy.exc.IntegrityError,
        ) as e:
            log.error(e)
            client.session.rollback()
            raise APIException()

    return internal


@logged
class APIView(FlaskView):
    representations = {"application/json": output_json}
    model = None
    pk_field = "id"
    excluded_methods = ["get_queryset"]
    route_base = None

    def __new__(cls, *args, **kwargs):
        name = re.sub("APIView", "", cls.__name__).lower()
        cls.model = cls.model or name
        cls.route_base = cls.route_base or f"/{name}"

        return FlaskView.__new__(cls, *args, **kwargs)

    def get_queryset(self, method, *args, **kwargs):
        cli = client
        return getattr(cli, f"{method}_{self.model}")(*args, **kwargs)

    @protected
    def post(self):
        # it returns the event object
        return self.get_queryset("create", **request.json).as_dict()

    @protected
    def index(self):
        return self.get_queryset("get").all()

    @protected
    def get(self, id: int):
        return self.get_queryset("get", **{self.pk_field: id}).one()

    @protected
    def put(self, id: int):
        # here I would get the post data and update stuff
        kwargs = request.json

        obj = self.get_queryset("get", **{self.pk_field: id}).one()
        nu_obj = client.update(obj, **kwargs)

        return nu_obj.as_dict()

    @protected
    def delete(self, id: int):
        obj = self.get_queryset("get", **{self.pk_field: id}).one()

        client.session.remove(obj)

        return {}


class APIException(HTTPException):
    code = 400
    description = "bad request"

    def get_description(
        self,
        environ=None,
        scope=None,
    ) -> str:
        """Get the description."""
        if self.description is None:
            description = ""
        elif not isinstance(self.description, str):
            description = str(self.description)
        else:
            description = self.description
        return description

    def get_body(
        self,
        environ=None,
        scope=None,
    ) -> str:
        """Get the HTML body."""
        return encoder.encode(
            {"status_code": self.code, "errors": self.get_description()}
        )

    def get_headers(
        self,
        environ=None,
        scope=None,
    ):
        """Get a list of headers."""
        return {
            "Content-Type": "application/json",
        }


# error handling
@app.errorhandler(APIException)
def handle_exception(e):
    return output_json(e.get_body(), e.code, e.get_headers())


@app.errorhandler(sqlalchemy.exc.NoResultFound)
def handle_not_found(e):
    e = APIException("Resource not found")
    e.code = 404
    return output_json(e.get_body(), e.code, e.get_headers())


@app.teardown_appcontext
def shutdown_session(exception=None):
    client.session.remove()


class MovieAPIView(APIView):
    @protected
    def index(self):
        args = request.args
        limit = min(int(args.get("limit", 50)), 1000)
        offset = int(args.get("offset", 0))

        if "tags" not in args:
            return self.get_queryset("get").offset(offset).limit(limit).all()

        tags = args.get("tags", "")
        tags = list(map(int, tags.split(",")))

        release_year = int(args.get("release_year", 0))

        return (
            client.search(tags=tags, release_year=release_year)
            .order_by(Movie.votes.desc())
            .offset(offset)
            .limit(limit)
            .all()
        )

    @route("/list/<provider>/")
    @protected
    def landing_page_list(self, provider: str):
        args = request.args

        limit = min(int(args.get("limit", 50)), 1000)

        if provider == "netflix":
            return (
                client.get_movie()
                .filter(
                    and_(
                        Movie.title.in_(STATIC_NETFLIX_LIST.keys()),
                        Movie.runtime.in_(STATIC_NETFLIX_LIST.values()),
                    )
                )
                .limit(limit)
                .all()
            )
        return []


class TagAPIView(APIView):
    @protected
    def index(self):
        args = request.args
        limit = min(int(args.get("limit", 50)), 1000)
        offset = int(args.get("offset", 0))
        movies_containing_tag = args.get("containing", None)

        kwargs = {}
        if "category" in args:
            kwargs = {"category": args["category"]}
        valid_alpha = (
            args.get("category", "").isalpha() and args.get("containing", "").isalnum()
        )
        if movies_containing_tag and "category" in args and valid_alpha:
            return client.session.scalars(
                # extra join; first join is not required because we have the provider's tag id
                select(Tag).from_statement(
                    text(
                        f"SELECT t2.id, t2.name, t2.category FROM tag t1 JOIN tagged_movie tm1 ON t1.id = tm1.tag_id JOIN tagged_movie tm2 ON tm1.movie_id = tm2.movie_id join tag t2 ON tm2.tag_id = t2.id WHERE t1.id = {movies_containing_tag} AND t2.category = '{args['category']}' GROUP BY t2.id;"
                    )
                )
            ).all()
        return (
            self.get_queryset("get", **kwargs)
            .join(TaggedMovie, Tag.id == TaggedMovie.tag_id)
            .group_by(Tag.id)
            .order_by(func.count(Tag.id).desc())
            .limit(limit)
            .all()
        )

    @protected
    def name(self, label):
        return self.get_queryset("get", name=label).one()


class LinkAPIView(APIView):
    pass


@logged
class TrailerAPIview(FlaskView):
    representations = {"application/json": output_json}
    model = None
    pk_field = "id"
    excluded_methods = ["get_queryset"]
    route_base = None

    def get(self, id: int):
        self.get_queryset(
            "get",
        )


# populate urls
_loc = locals().copy()
_keys = _loc.keys()
for namespace in _keys:
    if namespace.endswith("APIView") and namespace != "APIView":
        if issubclass(_loc[namespace], APIView):
            view = _loc[namespace]
            view.register(api)

app.register_blueprint(api)


def runserver():
    app.run(port=5051)
