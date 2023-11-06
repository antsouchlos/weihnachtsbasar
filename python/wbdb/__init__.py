from flask import Flask
from flask_cors import CORS
from wbdb.DBHandler import DBHandler
from wbdb.loggers import db_logger

app = Flask(__name__)
CORS(app)
db_handler = DBHandler(db_logger)

import wbdb.routes
