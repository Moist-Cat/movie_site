import os
import sys

from movieapp.db import create_db
from movieapp.conf import settings
from movieapp.test.test_ft import run_test_server
from movieapp.server import runserver


def get_command(command: list = sys.argv[1]):
    """Macros to manage the db"""
    if command == "shell":
        import movieapp.test.shell

    elif command == "migrate":
        create_db()

    elif command == "test":
        os.system(f"python -m pytest {settings.BASE_DIR / 'test'}")

    elif command == "runserver":
        runserver()

    elif command == "livetest":
        run_test_server()

    elif command == "debug":
        os.system(f"cat {str(settings.BASE_DIR / 'logs'/ 'api.error')}")
    else:
        print(f"Bad command {command}")


if __name__ == "__main__":
    get_command()
