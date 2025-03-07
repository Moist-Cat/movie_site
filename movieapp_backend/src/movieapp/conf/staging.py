from movieapp.conf._base import *

# Paths
TEST_DIR = Path(__file__).parent.parent / "test"

# Config
DEBUG = True
# Database
DATABASES = {
    "test": {
        "engine": f"sqlite:///{TEST_DIR}/test_db.sqlite",
        "config": {"autocommit": True},
    },
    "default": {
        "engine": "mysql+pymysql://drycat:movieapp@drycat.mysql.pythonanywhere-services.com/drycat$movieapp",
        "config": {
            "pool_recycle": 3600,
            "pool_pre_ping": True,
        },
    },
}
