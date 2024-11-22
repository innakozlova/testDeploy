#единица информации в REST это ресурсы:
#пользователи и новости

from flask import Flask
from flask_restful import reqparse, abort, Api, Resource


app = Flask(__name__)
api=Api(app)
