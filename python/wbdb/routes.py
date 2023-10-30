from wbdb import utility
from wbdb import app, _db_handler
from flask import request, json, jsonify
import bleach


@app.route("/api/v1/upload/register", methods=["POST"])
def register():
    if request.method == 'POST':
        name = bleach.clean(request.form['name'])
        email = bleach.clean(request.form['email'])
        phone = bleach.clean(request.form['phone'])
        stand = bleach.clean(request.form['stand'])
        shift = bleach.clean(request.form['shift'])

        if (name is None) or (email is None) or (phone is None) or (
                stand is None) or (shift is None):
            return utility.gen_error("Missing data fields.")
        else:
            _db_handler.register(name, email, phone, stand, shift)

            response = jsonify({
                'status': 'SUCCESS',
                'message': 'Successfully received data'
            })
            response.headers.add('Access-Control-Allow-Origin', '*')
            return response
    else:
        return utility.gen_error("Wrong method.")


@app.route("/api/v1/download/standdata", methods=["POST"])
def get_stand_data():
    if request.method == 'POST':
        stand = bleach.clean(request.form['stand'])

        if stand is None:
            return utility.gen_error("Missing data fields.")
        else:
            data = _db_handler.get_stand_data(stand)
            response = jsonify(data)
            response.headers.add('Access-Control-Allow-Origin', '*')
            return response
    else:
        return utility.gen_error("Wrong method.")
