import os
from flask import Flask, request, jsonify
from firebase_admin import credentials, firestore, initialize_app
import datetime

#initialize Flask app

app = Flask(__name__)

#initialize Firebase Database
cred = credentials.Certificate('SecretKey.json')
default_app = initialize_app(cred)
db = firestore.client()
workouts_ref = db.collection(u'workout')
test_ref = db.collection(u'TESTING')


@app.route('/test', methods = ['GET'])
def test():
    try:
        data = test_ref.stream()
        ret = [d.to_dict() for d in data]
        return jsonify(ret), 200
        
    except Exception as e:
        return f"An Error Occured: {e}"
# @app.route('/addWorkout', methods = ["POST"])
# def addWorkout():
#     try:
#         data = request.json
#         data["dateAdded"] = datetime.now()
#         workouts_ref.add(data)
#         return jsonify({"success": True}), 200
#     except Exception as e:
#         return f"An Error Occurred: {e}"

@app.route('/allWorkouts', methods = ['GET'])
def getAllWorkouts():
    try:
        data = workouts_ref.stream()
        ret = [d.to_dict() for d in data]
        return jsonify(ret), 200
    except Exception as e:
        return f"An Error Occurred: {e}"

@app.route('/workoutsByUser', methods = ["GET"])
def getWorkouts():
    try:
        args = request.args

        if "userID" in args:
            data = workouts_ref.where("userID", '==', args["userID"]).stream()
        else:
            data = workouts_ref.stream()

        ret = [d.to_dict() for d in data]
        return jsonify(ret), 200
    except Exception as e:
        return f"An Error Occurred: {e}"
#TODO
#create PUT endpoint to edit workouts


#create endpoints for user


        



port = int(os.environ.get('PORT', 8080))
if __name__ == '__main__':
    app.run(threaded=True, host='0.0.0.0', port=port)