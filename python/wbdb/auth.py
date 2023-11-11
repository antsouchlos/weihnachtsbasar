from flask_httpauth import HTTPBasicAuth
from werkzeug.security import check_password_hash
from wbdb import db_handler
from functools import wraps
from wbdb import db_handler

#
# Authentication stuff
#

auth = HTTPBasicAuth()


@auth.verify_password
def verify_password(email, password):
    users = db_handler.get_users()

    for user in users:
        if (user["email"] == email) and check_password_hash(
                user["password_hash"], password):
            return user

    return False


@auth.get_user_roles
def get_user_roles(user):
    return user["roles"]


#
# Authorization stuff
#

def require_standname_or_admin_role(f):
    """The effect of this decorator is requiring login and only authorizing
    access when the role of the logged-in user matches 'admin' or a kwarg with
    the key 'stand_slug'.
    """

    @wraps(f)
    def dec_func(*args, **kwargs):
        @auth.login_required(role=[db_handler._get_stand_slug_by_name(kwargs['standname']), "admin"])
        def proxy_func():
            return f(*args, **kwargs)

        return proxy_func()

    return dec_func
