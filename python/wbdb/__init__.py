from flask import Flask
from wbdb.DBHandler import DBHandler

app = Flask(__name__)
_db_handler = DBHandler()

import wbdb.routes
