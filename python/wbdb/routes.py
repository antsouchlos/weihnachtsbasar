from flask import request, json, jsonify
import bleach
import logging
import sys
from wbdb import utility
from wbdb import app
from wbdb import db_handler

from wbdb.loggers import route_logger as route_logger
from wbdb.auth import auth, require_stand_slug_or_admin_role

from werkzeug.security import generate_password_hash


# #
# # Registration stuff
# #
#
#
# @app.route("/api/v1/registration/create", methods=["POST"])
# def register():
#     """Register a new helper."""
#     # Fetch and validate request data
#
#     name = bleach.clean(request.form['name'])
#     email = bleach.clean(request.form['email'])
#     phone = bleach.clean(request.form['phone'])
#     standname_de = bleach.clean(request.form['standname_de'])
#     shift_id = int(bleach.clean(request.form['shift_id']))
#
#     if (name is None) or (email is None) or (phone is None) or (
#             standname_de is None) or (shift_id is None):
#         return utility.gen_error("Missing data fields.")
#
#     # Perform registration
#
#     try:
#         db_handler.register(name, email, phone, standname_de, shift_id)
#         route_logger.info(
#             f"Registered new helper: ({name}, {email}, {phone}, {standname_de},"
#             f"{shift_id}])")
#         return utility.gen_success("Successfully registered.")
#     except Exception as e:
#         route_logger.exception(
#             f"Exception occurred while registering new helper")
#         return utility.gen_error("Unable to register.")
#
#
# @app.route("/api/v1/registration/remove/<path:standname>", methods=["POST"])
# @require_stand_slug_or_admin_role
# def remove_registration(standname):
#     """Remove a helper registration."""
#     # Fetch and validate request data
#
#     shift = bleach.clean(request.form['shift'])
#     email = bleach.clean(request.form['email'])
#
#     if (standname is None) or (shift is None) or (email is None):
#         return utility.gen_error("Missing data fields.")
#
#     # Remove registration
#
#     try:
#         db_handler.remove_registration(standname, shift, email)
#         route_logger.info(
#             f"Removed registration: ({standname}, {shift}, {email})")
#         return utility.gen_success("Successfully removed registration.")
#     except Exception as e:
#         route_logger.exception(
#             f"Exception occurred while removing registration")
#         return utility.gen_error("Unable to remove registration.")
#
#
# #
# # Stand stuff
# #
#
# @app.route("/api/v1/stands/create", methods=["POST"])
# @auth.login_required(role="admin")
# def create_stand():
#     """Create a new stand."""
#     # Fetch and validate request data
#
#     standname_de = bleach.clean(request.form['standname_de'])
#     standname_gr = bleach.clean(request.form['standname_gr'])
#
#     if (standname_de is None) or (standname_gr is None):
#         return utility.gen_error("Missing data fields.")
#
#     # Create stand
#
#     try:
#         db_handler.add_stand(standname_de, standname_gr)
#         route_logger.info(
#             f"Created new stand: ({standname_de}, {standname_gr})")
#         return utility.gen_success("Created stand")
#     except Exception as e:
#         route_logger.exception(
#             f"Exception occurred while creating stand")
#         return utility.gen_error("Unable to create stand")
#
#
# @app.route("/api/v1/stands/remove", methods=["POST"])
# @auth.login_required(role="admin")
# def remove_stand():
#     """Remove an existing stand."""
#     # Fetch and validate request data
#
#     standname_de = bleach.clean(request.form['standname_de'])
#
#     if standname_de is None:
#         return utility.gen_error("Missing data fields.")
#
#     # Remove stand
#
#     try:
#         db_handler.remove_stand(standname_de)
#         route_logger.info(
#             f"Removed stand: {standname_de}")
#         return utility.gen_success("Removed stand")
#     except Exception as e:
#         route_logger.exception(
#             f"Exception occurred while removing stand")
#         return utility.gen_error("Unable to remove stand")
#
#
# @app.route("/api/v1/stands/download", methods=["GET"])
# def get_stands():
#     """Get a list of all possible shifts."""
#     try:
#         data = db_handler.get_stands()
#         response = jsonify(data)
#         response.headers.add('Access-Control-Allow-Origin', '*')
#         route_logger.info(f"Fetched list of all stands")
#         return response
#     except Exception as e:
#         route_logger.exception(f"Exception occurred while fetching stands")
#         return utility.gen_error("Unable to download stands.")
#
#
# #
# # Shift stuff
# #
#
#
# @app.route("/api/v1/shifts/create", methods=["POST"])
# @auth.login_required(role="admin")
# def add_shift():
#     """Add a new shift."""
#     # Fetch and validate request data
#
#     text_de = bleach.clean(request.form['text_de'])
#     text_gr = bleach.clean(request.form['text_gr'])
#
#     if (text_de is None) or (text_gr is None):
#         return utility.gen_error("Missing data fields.")
#
#     # Create shift
#
#     try:
#         db_handler.add_shift(text_de, text_gr)
#         route_logger.info(f"Created new shift: ({text_de}, {text_gr})")
#         return utility.gen_success("Created new shift")
#     except Exception as e:
#         route_logger.exception(f"Exception occurred while creating new shift")
#         return utility.gen_error("Unable to create shift.")
#
#
# @app.route("/api/v1/shifts/remove", methods=["POST"])
# @auth.login_required(role="admin")
# def remove_shift():
#     """Remove existing shift."""
#     # Fetch and validate request data
#
#     shift_id = bleach.clean(request.form['shift_id'])
#
#     if shift_id is None:
#         return utility.gen_error("Missing data fields.")
#
#     # Remove shift
#
#     try:
#         db_handler.remove_shift(int(shift_id))
#         route_logger.info(f"Removed shift: {shift_id}")
#         return utility.gen_success("Removed shift")
#     except Exception as e:
#         route_logger.exception(f"Exception occurred while removing shift")
#         return utility.gen_error("Unable to remove shift.")
#
#
# @app.route("/api/v1/shifts/download", methods=["GET"])
# def get_shifts():
#     """Get a list of all possible shifts."""
#     try:
#         data = db_handler.get_shifts()
#         response = jsonify(data)
#         response.headers.add('Access-Control-Allow-Origin', '*')
#         route_logger.info(f"Fetched list of all shifts")
#         return response
#     except Exception as e:
#         route_logger.exception(f"Exception occurred while fetching shifts")
#         return utility.gen_error("Unable to download shifts.")
#
#
# #
# # User management
# #
#
#
# # TODO: Should multiple roles per user be possible?
# @app.route("/api/v1/users/create", methods=["POST"])
# @auth.login_required(role="admin")
# def create_user():
#     """Create new user."""
#
#     username = bleach.clean(request.form['username'])
#     password = bleach.clean(request.form['password'])
#     role = bleach.clean(request.form['role'])
#
#     if (username is None) or (password is None) or (role is None):
#         return utility.gen_error("Missing data fields.")
#
#     # Create user
#
#     try:
#         password_hash = generate_password_hash(password)
#         db_handler.add_user(username, password_hash, roles=[role])
#         route_logger.info(f"Created user: {username}")
#         return utility.gen_success("Created user")
#     except Exception as e:
#         route_logger.exception(f"Exception occurred while creating user")
#         return utility.gen_error("Unable to create user.")
#
#
# @app.route("/api/v1/users/remove", methods=["POST"])
# @auth.login_required(role="admin")
# def remove_user():
#     """Remove existing shift."""
#     # Fetch and validate request data
#
#     username = bleach.clean(request.form['username'])
#
#     if username is None:
#         return utility.gen_error("Missing data fields.")
#
#     # Remove user
#
#     if username == auth.username():
#         route_logger.debug("Attempted to delete user used for auth")
#         return utility.gen_error("Cant remove user used for auth")
#
#     try:
#         db_handler.remove_user(username)
#         route_logger.info(f"Removed user: {username}")
#         return utility.gen_success("Removed user")
#     except Exception as e:
#         route_logger.exception(f"Exception occurred while removing user")
#         return utility.gen_error("Unable to remove user.")
#
#
# @app.route("/api/v1/users/download", methods=["GET"])
# @auth.login_required(role="admin")
# def get_users():
#     """Get a list of all possible shifts."""
#     try:
#         data = db_handler.get_users()
#         response = jsonify(data)
#         response.headers.add('Access-Control-Allow-Origin', '*')
#         route_logger.info(f"Fetched list of all users")
#         return response
#     except Exception as e:
#         route_logger.exception(f"Exception occurred while fetching users")
#         return utility.gen_error("Unable to download users.")
#
#
# #
# # Misc
# #
#
#
# @app.route("/api/v1/standdata/download/<path:stand_slug>", methods=["GET"])
# @require_stand_slug_or_admin_role
# def get_stand_data(stand_slug):
#     """Get a list of shifts, containing lists of helpers, for a given stand."""
#     try:
#         data = db_handler.get_stand_data(stand_slug)
#         response = jsonify(data)
#         response.headers.add('Access-Control-Allow-Origin', '*')
#         route_logger.info("Fetched stand data")
#         return response
#     except Exception as e:
#         route_logger.exception(
#             f"Exception occurred while fetching stand data")
#         return utility.gen_error("Unable to download stand data.")


#
# API V2
#

@app.route("/api/v2/shifts", methods=["GET"])
def get_shifts():
    """Get a list of all possible shifts."""
    try:
        data = db_handler.get_shifts()
        response = jsonify(data)
        response.headers.add('Access-Control-Allow-Origin', '*')
        route_logger.info(f"Fetched list of all shifts")
        return response
    except Exception as e:
        route_logger.exception(f"Exception occurred while fetching shifts")
        return utility.gen_error("Unable to download shifts")


@app.route("/api/v2/shifts", methods=["POST"])
def post_shift():
    """Add new shift."""
    # Fetch and validate request data

    text_de = bleach.clean(request.form['text_de'])
    text_gr = bleach.clean(request.form['text_gr'])

    if (text_de is None) or (text_gr is None):
        return utility.gen_error("Missing data fieldss")

    try:
        db_handler.add_shift(text_de, text_gr)
        route_logger.info(f"Added new shift: ({text_de, text_gr})")
        return utility.gen_success("Added new shift")
    except Exception as e:
        route_logger.exception(f"Exception occurred while adding shift")
        return utility.gen_error("Unable to add shift")


@app.route("/api/v2/shifts/<path:shift_id>", methods=["DELETE"])
def delete_shift(shift_id):
    """Add new shift."""
    shift_id = int(bleach.clean(shift_id))

    try:
        db_handler.remove_shift(shift_id)
        route_logger.info(f"Removed shift: {shift_id}")
        return utility.gen_success("Removed shift")
    except Exception as e:
        route_logger.exception(f"Exception occurred while removing shift")
        return utility.gen_error("Unable to remove shift")


@app.route("/api/v2/stands", methods=["GET"])
def get_stands():
    """Get a list of all possible stands."""
    try:
        data = db_handler.get_stands()
        response = jsonify(data)
        response.headers.add('Access-Control-Allow-Origin', '*')
        route_logger.info(f"Fetched list of all stands")
        return response
    except Exception as e:
        route_logger.exception(f"Exception occurred while fetching stands")
        return utility.gen_error("Unable to download stands")
