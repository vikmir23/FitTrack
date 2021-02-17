import os
from flask import Flask, request, jsonify
from firebase_admin import credentials, firestore, initialize_app

#initialize Flask app

app = Flask(__name__)
