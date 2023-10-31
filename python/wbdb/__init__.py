from flask import Flask
from wbdb.DBHandler import DBHandler
from wbdb.loggers import db_logger

app = Flask(__name__)
db_handler = DBHandler(db_logger)

import wbdb.routes
