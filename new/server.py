from flask import Flask
from waitress import serve

app = Flask(__name__)

@app.route('/')
def index():
    return """<html>
    <head>
	<title>Flask-page</title>
	<meta charset="utf-8">
    </head>
    <body>
        <img src="static/sample.jpeg">
    </body>
    </html>
    """

if __name__ == "__main__":
    serve(app, host='0.0.0.0', port=5000)
##    app.run()