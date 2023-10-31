from flask import jsonify


def gen_error(message):
    response = jsonify({
        'status': 'ERROR',
        'message': message
    })
    response.headers.add('Access-Control-Allow-Origin', '*')
    return response


def gen_success(message):
    response = jsonify({
        'status': 'SUCCESS',
        'message': message
    })
    response.headers.add('Access-Control-Allow-Origin', '*')
    return response
