#!/usr/bin/python
#
# A mini Flask rest api server
# Author: Gary Sin
# Version: 1.0
# Notes: Use it at your own risk
#

from flask import Flask, jsonify, abort, make_response, request
import redis
import os

# Check if there is any external redis server.
# If REDIS_ENDPOINT is set, connect to the external server.
if os.environ.get('REDIS_ENDPOINT') is not None:
    if os.environ.get('REDIS_PORT') is not None:
        r = redis.Redis(host=os.environ["REDIS_ENDPOINT"],port=os.environ["REDIS_PORT"])
    else:
        r = redis.Redis(host=os.environ["REDIS_ENDPOINT"])
else:
    # initial setting for testing
    r = redis.Redis()

api = Flask(__name__)

@api.route('/key/<id>', methods=['GET'])
def get_value(id):
    print("Retrieve key/value pair")

    if r.exists(id):
    # Retrieve value by key id
        result = r.get(id).decode('utf-8')
    else:
        result = 0

    # if nothing is found, return 404
    if result == 0:
        abort(404)

    # Return key/value pair
    return jsonify({"key":id,"value":result}), 200

@api.route('/key', methods=['PUT'])
def add_value():
    print("Adding key/value pair")

    # Check if the JSON contains key and value.  If not, return HTTP 500
    if not request.json or not 'value' in request.json or not 'key' in request.json:
        abort(500)

    # Add the key/value pair to the redis server
    r.set(request.json['key'],request.json['value'])

    # Return HTTP 202 when success
    return make_response(jsonify({'success': 'Key/Value pair is added'}), 202)

@api.route('/')
def index():
    return "Hello World"

@api.errorhandler(404)
def not_found(error):
    return make_response(jsonify({'error': 'Not found'}),404)

if __name__ == '__main__':
    api.run(host='0.0.0.0')
