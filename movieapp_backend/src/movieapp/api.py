"""API"""
import base64
from datetime import datetime
from functools import wraps, lru_cache
import inspect
import logging
import pathlib
import pickle
import time

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy import and_

from movieapp.conf import settings
from movieapp.db import (
    Movie,
    Tag,
    TaggedMovie,
    Link,
)
from movieapp.log import logged

log = logging.getLogger("global")

DB = settings.DATABASES["default"]
URL = DB["engine"]


@logged
class Client:
    def __init__(self, url=URL, config=None):
        config = config or {}
        self.url = url
        self.config = config
        self.logger.info("Started %s. Engine: %s", self.__class__.__name__, URL)

        self.engine = create_engine(url)

        Session = sessionmaker(bind=self.engine, **config)  # pylint: --disable=C0103
        self.session = Session()

    def __delete__(self, obj):
        self.session.rollback()
        self.session.close()

    def __str__(self):
        return f"[Client] ({self.url=} {self.config=})"

    # low level
    def _get(self, Obj, /, **kwargs):
        """Low level GET implementation"""
        query = self.session.query(Obj)
        for k, v in kwargs.items():
            query = query.filter(getattr(Obj, k) == v)

        return query

    def _create(self, Obj, /, **kwargs):
        """Low level insert implementation"""
        obj = Obj(**kwargs)
        self.session.add(obj)
        # self.session.commit()

        return obj

    def update(self, obj, /, **kwargs):
        """Update implementation. Feel free to use this directly"""

        if isinstance(obj, Base):
            for k, v in kwargs.items():
                setattr(obj, k, v)
            # self.session.add(obj)
            # self.session.commit()
        elif getattr(obj, "__name__"):
            # model class
            query = self.session.query(obj)
            obj = query.update(**kwargs).one()
        else:
            raise AssertionError(f"{obj} is not update-able")

        return obj

    def _get_or_create(self, Obj, /, **kwargs):
        """Low level select or insert  implementation"""
        obj = self._get(Obj, **kwargs).all()
        if not obj:
            return self._create(Obj, **kwargs)
        obj = obj[0]
        return obj

    # crud
    def create_movie(self, /, **kwargs):
        return self._create(Movie, **kwargs)

    def get_movie(self, /, **kwargs):
        return self._get(Movie, **kwargs)

    def get_or_create_movie(self, /, **kwargs):
        return self._get_or_create(Movie, **kwargs)

    def get_movie_tags(self, id):
        return self.get_tag(
        ).join(
            TaggedMovie,
            and_(
                Tag.id == TaggedMovie.tag_id,
                TaggedMovie.movie_id == id,
            )
        )

    def create_tagged_movie(self, /, **kwargs):
        return self._create(TaggedMovie, **kwargs)

    def get_tagged_movie(self, /, **kwargs):
        return self._get(TaggedMovie, **kwargs)

    def create_tag(self, /, **kwargs):
        return self._create(Tag, **kwargs)

    def get_tag(self, /, **kwargs):
        return self._get(Tag, **kwargs)

    def get_or_create_tag(self, /, **kwargs):
        return self._get_or_create(Tag, **kwargs)

    def create_link(self, /, **kwargs):
        return self._create(Link, **kwargs)

    def get_link(self, /, **kwargs):
        return self._get(Link, **kwargs)

    def search(self, tags, min_rating: float=0.0):
        """
        SELECT * FROM movie m JOIN tag t ON m.id = t.movie_ie AND t.name IN {tags} WHERE m.rating > min_rating GROUP BY m.id;
        """
        return self.get_movie(
        ).filter(
            Movie.rating > min_rating
        ).join(
            TaggedMovie,
            and_(
                Movie.id == TaggedMovie.movie_id, TaggedMovie.tag_id.in_(tags)
            )
        ).group_by(Movie.id)
