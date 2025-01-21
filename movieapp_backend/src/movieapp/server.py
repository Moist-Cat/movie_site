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
from sqlalchemy import func

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

    @route("/<int:id>/trailer/")
    @protected
    def trailer(self, id: int):
        """
        Get the trailer of a movie by grabbing it from imdb dynamically.
        The link expires so we have to do this every time.
        """
        obj = self.get_queryset("get", **{self.pk_field: id}).one()
        page = None
        for link in obj.links:
            if link.label == LinkLabel.METADATA and "imdb" in link.url:
                page = link.url
                break

        if page is None:
            raise APIException(f"No trailer available for {obj.title}")

        res = requests.get(page, headers={"User-Agent": ""})
        soup = BeautifulSoup(res.text, "html.parser")

        next_data = json.loads(soup.find(id="__NEXT_DATA__").text)

        trailer_url = next_data["props"]["pageProps"]["aboveTheFoldData"][
            "primaryVideos"
        ]["edges"][0]["node"]["playbackURLs"][0]["url"]

        return {
            # it might look silly but we require it to identify the movie after calling
            "id": obj.id,
            "url": trailer_url,
        }


class TagAPIView(APIView):
    @protected
    def index(self):
        args = request.args
        limit = min(int(args.get("limit", 50)), 1000)
        offset = int(args.get("offset", 0))

        kwargs = {}
        if "category" in args:
            kwargs = {"category": args["category"]}
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
