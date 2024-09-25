from movieapp.conf._base import *

# Config
DEBUG = False

# Database
DATABASES = {
        "default": {
            "engine": f"postgresql:///movieapp:password@host/movieapp",
        }
}
