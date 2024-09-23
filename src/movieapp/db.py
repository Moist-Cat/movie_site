"""
ORM layer for the DB
"""
import os
from enum import Enum
import logging
import shutil
import random
import re
import pathlib
from warnings import warn
import pickle
import base64

from sqlalchemy import Column, create_engine, func
from sqlalchemy import (
    Integer,
    Float,
    String,
    Text,
    Boolean,
    ForeignKey,
)
from sqlalchemy.sql import text
from sqlalchemy.ext.declarative import declared_attr
from sqlalchemy.orm import relationship, as_declarative, validates
from sqlalchemy.schema import UniqueConstraint, CheckConstraint

from movieapp.conf import settings
from movieapp.log import logged

logger = logging.getLogger("user_info." + __name__)


@as_declarative()
class Base:
    """Automated table name, surrogate pk, and serializing"""

    @declared_attr
    def __tablename__(cls):  # pylint: --disable=no-self-argument
        cls_name = cls.__name__
        table_name = list(cls_name)
        for index, match in enumerate(re.finditer("[A-Z]", cls_name[1:])):
            table_name.insert(match.end() + index, "_")
        table_name = "".join(table_name).lower()
        return table_name

    def as_dict(self):
        """
        I won't recursively serialialize all related fields because it will cause trouble
        with circular dependencies (for example, in Location, Paths can lead eventually to the same Location)
        """
        return {
            column: getattr(self, column) for column in self.__table__.columns.keys()
        }

    def __str__(self):
        return f"[ {self.__class__.__name__} ] ({self.as_dict()})"

    def __repr__(self):
        return self.__str__()

    id = Column(Integer, primary_key=True)


class Movie(Base):
    title = Column(String(100), nullable=False)
    runtime = Column(Integer, nullable=False)
    release_year = Column(Integer, nullable=False) 
    rating = Column(Integer, CheckConstraint('rating >= 0 AND rating <= 1000'), default=0)

    links = relationship(
        "Link",
        back_populates="movie",
        cascade="all, delete",
        passive_deletes=True,
    )

    tags = relationship(
        "Tag",
        secondary="tagged_movie",
        back_populates="movies",
    )

class Tag(Base):
    """
    Simple tags to keep track know if we should do X
    """

    name = Column(String(100), nullable=False, unique=True)
    category = Column(String(100), nullable=False)

    movies = relationship(
        "Movie",
        secondary="tagged_movie",
        back_populates="tags",
    )


class TaggedMovie(Base):
    movie_id = Column(None, ForeignKey("movie.id"), nullable=False)
    tag_id = Column(None, ForeignKey("tag.id"), nullable=False)

class Link(Base):
    """
    Metadata for movies with an URL
    """
    label = Column(String(100), nullable=False)
    url = Column(String(2048), nullable=False)

    movie_id = Column(None, ForeignKey("movie.id", ondelete='CASCADE'), nullable=False)
    movie = relationship(Movie, back_populates="links")

def create_db(name=settings.DATABASES["default"]["engine"]):
    """
    Create database and schema if and only if the schema was modified
    """
    engine = create_engine(name)
    Base.metadata.drop_all(engine)
    Base.metadata.create_all(engine)

    return str(engine.url)

def drop_db(name=settings.DATABASES["default"]["engine"]):
    engine = create_engine(name)
    Base.metadata.drop_all(engine)
