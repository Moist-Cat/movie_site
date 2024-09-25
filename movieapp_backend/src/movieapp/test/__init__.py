import os
import logging
from pathlib import Path

from movieapp.conf import Settings

settings = Settings("movieapp.conf.dev")

logger = logging.getLogger("user-info.test")

db = settings.DATABASES["test"]
ENGINE = db["engine"]
