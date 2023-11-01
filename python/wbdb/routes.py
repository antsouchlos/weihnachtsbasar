from flask import request, json, jsonify
import bleach
import logging
import sys
from wbdb import utility
from wbdb import app
from wbdb import db_handler

from wbdb.loggers import route_logger as route_logger

from werkzeug.security import generate_password_hash


#
# Registration stuff
#


@app.route("/api/v1/registration/create", methods=["POST"])
def register():
    """Register a new helper."""
    # Fetch and validate request data

    if request.method != 'POST':
        return utility.gen_error("Wrong method.")

    name = bleach.clean(request.form['name'])
    email = bleach.clean(request.form['email'])
    phone = bleach.clean(request.form['phone'])
    stand = bleach.clean(request.form['stand'])
    shift = bleach.clean(request.form['shift'])

    if (name is None) or (email is None) or (phone is None) or (
            stand is None) or (shift is None):
        return utility.gen_error("Missing data fields.")

    # Perform registration

    try:
        db_handler.register(name, email, phone, stand, shift)
        route_logger.info(
            f"Registered new helper: ({name}, {email}, {phone}, {stand},"
            f"{shift}])")
        return utility.gen_success("Successfully registered.")
    except Exception as e:
        route_logger.exception(
            f"Exception occurred while registering new helper")
        return utility.gen_error("Unable to register.")


@app.route("/api/v1/registration/remove", methods=["POST"])
def remove_registration():
    """Remove a helper registration."""
    # Fetch and validate request data

    if request.method != 'POST':
        return utility.gen_error("Wrong method.")

    stand = bleach.clean(request.form['stand'])
    shift = bleach.clean(request.form['shift'])
    email = bleach.clean(request.form['email'])

    if (stand is None) or (shift is None) or (email is None):
        return utility.gen_error("Missing data fields.")

    # Remove registration

    try:
        db_handler.remove_registration(stand, shift, email)
        route_logger.info(
            f"Removed registration: ({stand}, {shift}, {email})")
        return utility.gen_success("Successfully removed registration.")
    except Exception as e:
        route_logger.exception(
            f"Exception occurred while removing registration")
        return utility.gen_error("Unable to remove registration.")


#
# Shift stuff
#


@app.route("/api/v1/shifts/create", methods=["POST"])
def add_shift():
    """Add a new shift."""
    # Fetch and validate request data

    if request.method != 'POST':
        return utility.gen_error("Wrong method.")

    text_de = bleach.clean(request.form['text_de'])
    text_gr = bleach.clean(request.form['text_gr'])

    if (text_de is None) or (text_gr is None):
        return utility.gen_error("Missing data fields.")

    # Create shift

    try:
        db_handler.add_shift(text_de, text_gr)
        route_logger.info(f"Created new shift: ({text_de}, {text_gr})")
        return utility.gen_success("Created new shift")
    except Exception as e:
        route_logger.exception(f"Exception occurred while creating new shift")
        return utility.gen_error("Unable to create shift.")


@app.route("/api/v1/shifts/remove", methods=["POST"])
def remove_shift():
    """Remove existing shift."""
    # Fetch and validate request data

    if request.method != 'POST':
        return utility.gen_error("Wrong method.")

    shift_id = bleach.clean(request.form['shift_id'])

    if shift_id is None:
        return utility.gen_error("Missing data fields.")

    # Remove shift

    try:
        db_handler.remove_shift(int(shift_id))
        route_logger.info(f"Removed shift: {shift_id}")
        return utility.gen_success("Removed shift")
    except Exception as e:
        route_logger.exception(f"Exception occurred while removing shift")
        return utility.gen_error("Unable to remove shift.")


@app.route("/api/v1/shifts/download", methods=["POST"])
def get_shifts():
    """Get a list of all possible shifts."""
    # Fetch and validate request data

    if request.method != 'POST':
        return utility.gen_error("Wrong method.")

    # Get shifts

    try:
        data = db_handler.get_shifts()
        response = jsonify(data)
        response.headers.add('Access-Control-Allow-Origin', '*')
        route_logger.info(f"Fetched list of all shifts")
        return response
    except Exception as e:
        route_logger.exception(f"Exception occurred while fetching shifts")
        return utility.gen_error("Unable to download shifts.")


#
# User management
#


# TODO: Should multiple roles per user be possible?
@app.route("/api/v1/users/create", methods=["POST"])
def create_user():
    """Create new user."""
    # Fetch and validate request data

    if request.method != 'POST':
        return utility.gen_error("Wrong method.")

    username = bleach.clean(request.form['username'])
    password = bleach.clean(request.form['password'])
    role = bleach.clean(request.form['role'])

    if (username is None) or (password is None) or (role is None):
        return utility.gen_error("Missing data fields.")

    # Create user

    try:
        password_hash = generate_password_hash(password)
        db_handler.add_user(username, password_hash, roles=[role])
        route_logger.info(f"Created user: {username}")
        return utility.gen_success("Created user")
    except Exception as e:
        route_logger.exception(f"Exception occurred while creating user")
        return utility.gen_error("Unable to create user.")


@app.route("/api/v1/users/remove", methods=["POST"])
def remove_user():
    """Remove existing shift."""
    # Fetch and validate request data

    if request.method != 'POST':
        return utility.gen_error("Wrong method.")

    username = bleach.clean(request.form['username'])

    if username is None:
        return utility.gen_error("Missing data fields.")

    # Remove shift

    try:
        db_handler.remove_user(username)
        route_logger.info(f"Removed user: {username}")
        return utility.gen_success("Removed user")
    except Exception as e:
        route_logger.exception(f"Exception occurred while removing user")
        return utility.gen_error("Unable to remove user.")


@app.route("/api/v1/users/download", methods=["POST"])
def get_users():
    """Get a list of all possible shifts."""
    # Fetch and validate request data

    if request.method != 'POST':
        return utility.gen_error("Wrong method.")

    # Get shifts

    try:
        data = db_handler.get_users()
        response = jsonify(data)
        response.headers.add('Access-Control-Allow-Origin', '*')
        route_logger.info(f"Fetched list of all users")
        return response
    except Exception as e:
        route_logger.exception(f"Exception occurred while fetching users")
        return utility.gen_error("Unable to download users.")


#
# Misc
#


@app.route("/api/v1/standdata/download", methods=["POST"])
def get_stand_data():
    """Get a list of shifts, containing lists of helpers for a stand."""
    # Fetch and validate request data

    if request.method != 'POST':
        return utility.gen_error("Wrong method.")

    stand = bleach.clean(request.form['stand'])

    if stand is None:
        return utility.gen_error("Missing data fields.")

    # Get stand data

    try:
        data = db_handler.get_stand_data(stand)
        response = jsonify(data)
        response.headers.add('Access-Control-Allow-Origin', '*')
        route_logger.info("Fetched stand data")
        return response
    except Exception as e:
        route_logger.exception(
            f"Exception occurred while fetching stand data")
        return utility.gen_error("Unable to download stand data.")
