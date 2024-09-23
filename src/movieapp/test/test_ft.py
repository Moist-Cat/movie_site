import signal
import glob
import os
import time
from multiprocessing import Process
import unittest
from unittest import skip

try:
    import requests
except ImportError:
    requests = None

from movieapp.test import settings

try:
    from movieapp.server import app
except ImportError:
    app = None

TEST_DIR = settings.TEST_DIR

PORT = 14548
HOST = "localhost"
LIVE_TEST = os.environ.get(
    "MOORU_LIVE_TEST", True
)  # Whether use an active test server (manual) or create one on-the-go (automatic)


def run_test_server():
    app.run(port=PORT, threaded=False)
    # clean up

    delete_test_data()


class TestServer(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        assert settings.DEBUG is True, "You can't test with production settings"
        if not LIVE_TEST:
            cls.server = Process(target=run_test_server)
            cls.server.start()

            _flag = False
            while not _flag:
                try:
                    time.sleep(0.2)
                    res = requests.get(f"http://{HOST}:{PORT}/api/game/")
                    _flag = res.ok
                except:
                    pass

            res = requests.post(
                f"http://{HOST}:{PORT}/api/game/", json={"name": "anon"}
            )

    @classmethod
    def tearDownClass(cls):
        if not LIVE_TEST:
            s = f"kill -s {signal.SIGINT.value} {cls.server.pid}"
            os.system(s)
            # cls.server.terminate()

    def setUp(self):

        assert requests, "Install requests"

        self.session = requests.Session()
        self.url = f"http://{HOST}:{PORT}/api/"

    def tearDown(self):
        self.session.close()


def main_suite() -> unittest.TestSuite:
    s = unittest.TestSuite()
    load_from = unittest.defaultTestLoader.loadTestsFromTestCase
    s.addTests(load_from(TestServer))

    return s


def run():
    t = unittest.TextTestRunner()
    t.run(main_suite())


if __name__ == "__main__":
    run()
