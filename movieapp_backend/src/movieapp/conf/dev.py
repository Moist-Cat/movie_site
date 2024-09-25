from movieapp.conf._base import *

# Paths
TEST_DIR = Path(__file__).parent.parent / "test"

# Config
DEBUG = True
# Database
DATABASES = {
        "test": {
            "engine": f"sqlite:///{TEST_DIR}/test_db.sqlite",
            "config": {"autocommit": True}
        },
        "default": {
            "engine": f"postgresql+psycopg://movieapp:movieapp@127.0.0.1:5432"
        }
}
