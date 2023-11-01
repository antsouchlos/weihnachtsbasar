from flask_httpauth import HTTPBasicAuth
from werkzeug.security import check_password_hash
from wbdb import db_handler

auth = HTTPBasicAuth()


@auth.verify_password
def verify_password(username, password):
    users = db_handler.get_users()

    for user in users:
        if (user["username"] == username) and check_password_hash(
                user["password_hash"], password):
            return user

    return False


@auth.get_user_roles
def get_user_roles(user):
    return user["roles"]
