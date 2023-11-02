import unicodedata
import re
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


def slugify(value, allow_unicode=False):
    """
    Taken from https://github.com/django/django/blob/master/django/utils
    /text.py
    Convert to ASCII if 'allow_unicode' is False. Convert spaces or repeated
    dashes to single dashes. Remove characters that aren't alphanumerics,
    underscores, or hyphens. Convert to lowercase. Also strip leading and
    trailing whitespace, dashes, and underscores.
    """
    value = str(value)
    if allow_unicode:
        value = unicodedata.normalize('NFKC', value)
    else:
        value = unicodedata.normalize('NFKD', value).encode('ascii',
                                                            'ignore').decode(
            'ascii')
    value = re.sub(r'[^\w\s-]', '', value.lower())
    return re.sub(r'[-\s]+', '-', value).strip('-_')
