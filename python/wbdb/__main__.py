from wbdb import app
from waitress import serve
from wbdb.loggers import system_logger

_port = 5000
_host = "0.0.0.0"

if __name__ == "__main__":
    while True:
        try:
            system_logger.debug(f"Starting server on {_host}:{_port}")
            serve(app, host=_host, port=_port)
        except Exception as e:
            system_logger.exception("Unhandled exception occurred")
