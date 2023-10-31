import logging
import sys

# Logging handlers

_formatter = logging.Formatter(
    '%(asctime)s [%(levelname)s] %(name)s: %(message)s')

_file_handler = logging.FileHandler("./wbdb.log")
_file_handler.setLevel(logging.DEBUG)
_file_handler.setFormatter(_formatter)

_stdout_handler = logging.StreamHandler(sys.stdout)
_stdout_handler.setLevel(logging.DEBUG)
_stdout_handler.setFormatter(_formatter)

# Loggers

route_logger = logging.getLogger("RouteLogger")
route_logger.propagate = False
route_logger.setLevel(logging.DEBUG)
route_logger.addHandler(_file_handler)
route_logger.addHandler(_stdout_handler)

db_logger = logging.getLogger("DatabaseLogger")
db_logger.propagate = False
db_logger.setLevel(logging.DEBUG)
db_logger.addHandler(_file_handler)
db_logger.addHandler(_stdout_handler)
