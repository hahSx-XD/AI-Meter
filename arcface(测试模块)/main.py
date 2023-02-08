from arcrouter import socketio,app

if __name__ == '__main__':
    socketio.run(app,host="0.0.0.0")
# eventlet.wsgi.server
# https://github.com/miguelgrinberg/Flask-SocketIO/blob/main/src/flask_socketio/__init__.py#L598-L625
