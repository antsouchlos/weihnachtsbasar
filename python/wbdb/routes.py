from flask import request, json, jsonify, send_file
import bleach
import logging
import sys
from wbdb import utility
from wbdb import app
from wbdb import db_handler
import os

from wbdb.loggers import route_logger as route_logger
from wbdb.auth import auth, require_standname_or_admin_role
from wbdb.mail import send_helper_email, send_responsible_email

from werkzeug.security import generate_password_hash


@app.route("/api/v2/shifts/", methods=["GET"])
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


@app.route("/api/v2/shifts/<path:standname>", methods=["GET"])
def get_shifts_for_stand(standname):
    """Get a list of shifts open for registration for a given stand."""
    try:
        # Handle API call before stands have been loaded
        if standname == "null":
            return get_shifts()

        data = db_handler.get_shifts_for_stand(standname)
        response = jsonify(data)
        response.headers.add('Access-Control-Allow-Origin', '*')
        route_logger.info(f"Fetched list of shifts open for registration")
        return response
    except Exception as e:
        route_logger.exception(
            f"Exception occurred while fetching shifts open for registration")
        return utility.gen_error(
            "Unable to download shifts open for registration")


@app.route("/api/v2/shifts", methods=["POST"])
@auth.login_required(role="admin")
def post_shift():
    """Add new shift."""
    # Fetch and validate request data

    text_de = bleach.clean(request.form['text_de'])
    text_gr = bleach.clean(request.form['text_gr'])

    # Add shift

    try:
        db_handler.add_shift(text_de, text_gr)
        route_logger.info(f"Added new shift: ({text_de, text_gr})")
        return utility.gen_success("Added new shift")
    except Exception as e:
        route_logger.exception(f"Exception occurred while adding shift")
        return utility.gen_error("Unable to add shift")


@app.route("/api/v2/shifts/<path:shift_id>", methods=["DELETE"])
@auth.login_required(role="admin")
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


@app.route("/api/v2/stands", methods=["POST"])
@auth.login_required(role="admin")
def post_stand():
    """Add new stand."""
    # Fetch and validate request data

    standname_de = bleach.clean(request.form['standname_de'])
    standname_gr = bleach.clean(request.form['standname_gr'])

    # Add stand

    try:
        db_handler.add_stand(standname_de, standname_gr)
        route_logger.info(f"Added new shift: ({standname_de, standname_gr})")
        return utility.gen_success("Added new stand")
    except Exception as e:
        route_logger.exception(f"Exception occurred while adding stand")
        return utility.gen_error("Unable to add stand")


@app.route("/api/v2/stands/<path:stand_slug>", methods=["DELETE"])
@auth.login_required(role="admin")
def delete_stand(stand_slug):
    """Add new shift."""
    stand_slug = bleach.clean(stand_slug)

    try:
        db_handler.remove_stand(stand_slug)
        route_logger.info(f"Removed stand: {stand_slug}")
        return utility.gen_success("Removed stand")
    except Exception as e:
        route_logger.exception(f"Exception occurred while removing stand")
        return utility.gen_error("Unable to remove stand")


@app.route("/api/v2/registrations", methods=["POST"])
def post_registration():
    """Add new registration."""
    # Fetch and validate request data

    helper_name = bleach.clean(request.form['name'])
    helper_surname = bleach.clean(request.form['surname'])
    helper_email = bleach.clean(request.form['email'])
    helper_phone = bleach.clean(request.form['phone'])
    standname = bleach.clean(request.form['standname'])
    shift_text = bleach.clean(request.form['shift_text'])
    language = bleach.clean(request.form['language'])

    # Add registration

    try:
        db_handler.add_registration(helper_name, helper_surname, helper_email, helper_phone, standname, shift_text)
        helper_name = f"{helper_name} {helper_surname}"
        route_logger.info(
            f"Added new registration: ({helper_name}, {helper_email}, {helper_phone}, {standname}, {shift_text})")
        user = db_handler.get_responsible_for_stand(standname)

        responsible_name = user["name"]
        #responsible_email = user["email"]
        responsible_email = "an.tsouchlos@gmail.com"
        responsible_phone = user["phone"]

        send_responsible_email(recipients=[responsible_email], helper_name=helper_name, helper_email=helper_email, helper_phone=helper_phone, stand=standname, shift=shift_text)
        send_helper_email(recipients=[helper_email], responsible_name=responsible_name, responsible_email=responsible_email, responsible_phone=responsible_phone, stand=standname, language=language)

        return utility.gen_success("Added new registration")
    except Exception as e:
        route_logger.exception(f"Exception occurred while adding registration")
        return utility.gen_error("Unable to add registration")


@app.route(
    "/api/v2/registrations/<path:standname>/<path:shift_text>/<path:email>",
    methods=["DELETE"])
@require_standname_or_admin_role
def delete_registration(standname, shift_text, email):
    """Remove existing registration."""
    # Fetch and validate request data

    standname = bleach.clean(standname)
    shift_text = bleach.clean(shift_text)
    email = bleach.clean(email)

    # Remove registration

    try:
        db_handler.remove_registration(standname, shift_text, email)
        route_logger.info(
            f"Removed registration: ({standname}, {shift_text}, {email})")
        return utility.gen_success("Removed registration")
    except Exception as e:
        route_logger.exception(
            f"Exception occurred while removing registration")
        return utility.gen_error("Unable to remove registration")


@app.route("/api/v2/registrations/<path:standname>/<path:shift_text>",
           methods=["GET"])
@require_standname_or_admin_role
def get_registrations(standname, shift_text):
    """Get registrations for a specific shift of a stand."""
    # Fetch and validate request data

    standname = bleach.clean(standname)
    shift_text = bleach.clean(shift_text)

    if (standname is None) or (shift_text is None):
        return utility.gen_error("Missing data fields")

    # Get data

    try:
        data = db_handler.get_registrations(standname, shift_text)
        response = jsonify(data)
        response.headers.add('Access-Control-Allow-Origin', '*')
        route_logger.info(f"Fetched list of relevant registrations")
        return response
    except Exception as e:
        route_logger.exception(
            f"Exception occurred while fetching registrations")
        return utility.gen_error("Unable to download registrations")


@app.route("/api/v2/registrations/download/", methods=["GET"])
@auth.login_required(role="admin")
def download_registrations():
    try:
        df = db_handler.get_all_registrations()
        df.to_excel(f"{os.getcwd()}/temp.xlsx")
        return send_file(f'{os.getcwd()}/temp.xlsx', as_attachment=True)
        route_logger.info(f"Sent data as excel")
    except Exception as e:
        route_logger.exception(
            f"Exception occurred while sending data as excel")
        return utility.gen_error("Unable to download registrations")


@app.route("/api/v2/registrations/status/<path:standname>/<path:shift_text>",
           methods=["POST"])
@require_standname_or_admin_role
def set_registration_status(standname, shift_text):
    """Open or close registration for a shift of a given stand."""
    # Fetch and validate request data

    standname = bleach.clean(standname)
    shift_text = bleach.clean(shift_text)
    status = ((bleach.clean(request.form['status'])) == "true")

    # Set registration status

    try:
        db_handler.set_registration_status(standname, shift_text, status)
        route_logger.info(
            f"Set registration status: ({standname}, {shift_text}, {status})")
        return utility.gen_success("Set registration status")
    except Exception as e:
        route_logger.exception(
            f"Exception occurred while setting registration status")
        return utility.gen_error("Unable to set registration status")


@app.route("/api/v2/registrations/status/<path:standname>/<path:shift_text>",
           methods=["GET"])
@require_standname_or_admin_role
def get_registration_status(standname, shift_text):
    """Open or close registration for a shift of a given stand."""
    # Fetch and validate request data

    standname = bleach.clean(standname)
    shift_text = bleach.clean(shift_text)

    # Get registration status

    try:
        data = db_handler.get_registration_status(standname, shift_text)
        response = jsonify(data)
        response.headers.add('Access-Control-Allow-Origin', '*')
        route_logger.info(f"Fetched registration status")
        return response
    except Exception as e:
        route_logger.exception(
            f"Exception occurred while fetching registration status")
        return utility.gen_error("Unable to get registration status")


@app.route("/api/v2/users", methods=["POST"])
@auth.login_required(role="admin")
def post_user():
    name = bleach.clean(request.form['name'])
    email = bleach.clean(request.form['email'])
    phone = bleach.clean(request.form['phone'])
    password = bleach.clean(request.form['password'])
    standname = bleach.clean(request.form['standname'])

    password_hash = generate_password_hash(password)

    try:
        db_handler.add_user(name, email, phone, password_hash, standname)
        route_logger.info(
            f"Added user: ({name}, {email}, {phone}, {password}, {standname})")
        return utility.gen_success("Added user")
    except Exception as e:
        route_logger.exception(f"Exception occurred while adding user")
        return utility.gen_error("Unable to add user")


@app.route("/api/v2/users/<path:email>", methods=["DELETE"])
@auth.login_required(role="admin")
def delete_user(email):
    email = bleach.clean(email)

    if email == auth.username():
        route_logger.debug("Attempted to delete user used for auth")
        return utility.gen_error("Cant remove user used for auth")

    try:
        db_handler.remove_user(email)
        route_logger.info(f"Removed user: {email}")
        return utility.gen_success("Removed user")
    except Exception as e:
        route_logger.exception(f"Exception occurred while deleting user")
        return utility.gen_error("Unable to delete user")


@app.route("/api/v2/users", methods=["GET"])
@auth.login_required(role="admin")
def get_users():
    try:
        data = db_handler.get_users()
        response = jsonify(data)
        response.headers.add('Access-Control-Allow-Origin', '*')
        route_logger.info(f"Fetched list of all users")
        return response
    except Exception as e:
        route_logger.exception(f"Exception occurred while fetching users")
        return utility.gen_error("Unable to download users")


@app.route("/api/v2/login", methods=["GET"])
@auth.login_required
def check_login_validity():
    try:
        users = db_handler.get_users()
        user = next(x for x in users if x['email'] == auth.username())

        route_logger.info(f"Verified user validity: {auth.username()}")

        if "admin" in user["roles"]:
            return utility.gen_success("admin")
        else:
            return utility.gen_success("non-admin")
    except Exception as e:
        route_logger.exception(f"Exception occurred while validating user")
        return utility.gen_error("Unable to validate user")


@app.route("/api/v2/users/stand/<path:email>", methods=["GET"])
@auth.login_required
def get_user_stand(email):
    try:
        data = db_handler.get_stands_for_user(email)
        response = jsonify(data)
        response.headers.add('Access-Control-Allow-Origin', '*')
        route_logger.info(f"Fetched list of all users")
        return response
    except Exception as e:
        route_logger.exception(
            f"Exception occurred while getting stand for user")
        return utility.gen_error("Unable to get stand for user")
