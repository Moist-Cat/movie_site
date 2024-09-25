from code import InteractiveConsole

# to avoid ^[[A nonsense when pressing up arrow
import readline
import sys
from sqlalchemy import func
from sqlalchemy.sql import text

from movieapp.conf import settings
from movieapp.db import *
from movieapp.server import *
from movieapp.api import *

if len(sys.argv) == 3:
    URL = get_save(sys.argv[2])
else:
    URL = settings.DATABASES["default"]["engine"]

client = Client(url=URL)

banner = """
#######################################
# moviapp database interactive console #
#######################################
A Client instance is already defined (as 'client') and connected to the database.
Use it to make queries.
"""
i = InteractiveConsole(locals=locals())
i.interact(banner=banner)
