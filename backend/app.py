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
user_ref = db.collection(u'users')

#base
@app.route('/')
def base():
 return '<h1>Yeah, this is Fittrack</h1>'

#test endpoint
@app.route('/test', methods = ['GET'])
def test():
    try:
        data = test_ref.stream()
        ret = [d.to_dict() for d in data]
        return jsonify(ret), 200
        
    except Exception as e:
        return f"An Error Occured: {e}"

'''
Workout schema
    id: string (generated by firebase)
    userId: string (authId of the user)
    date: dateTime (refers to date and time of workout)
    activities: list (activities performed)
        each element in list contains
        activity: string
        reps: int
'''
#workout endpoints
@app.route('/addWorkout', methods = ["POST"])
def addWorkout():
    try:
        data = request.json
        data["dateAdded"] = datetime.now()
        workouts_ref.add(data)
        return jsonify({"success": True}), 200
    except Exception as e:
        return f"An Error Occurred: {e}"

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

        if "userId" in args:
            data = workouts_ref.where("userID", '==', args["userID"]).stream()
        else:
            data = workouts_ref.stream()

        ret = [d.to_dict() for d in data]
        return jsonify(ret), 200
    except Exception as e:
        return f"An Error Occurred: {e}"

@app.route('/workoutsByUserDate', methods = ['GET'])
def getWorkoutsByDate():
    try:
        args = request.args
        data = []
        if 'userId' in args:
            q = workouts_ref.where("userID", '==', args["userID"]).order_by(u"dateAdded")
            data = q.stream()
        ret = [d.to_dict() for d in data]
        return jsonify(ret), 200
        
    except Exception as e:
        return f"An Error Occurred: {e}"

#TODO
#create PUT endpoint to edit workouts


'''
User schema
id: string (generated by firebase)
authId: string (id given to user on login)
gender: string
age: number
height: number
currweight: number
goalweight: number
'''

#user endpoints
@app.route('/addUser', methods = ['POST'])
def addUser():
    try:
        data = request.json
        user_ref.add(data)
        return jsonify({"success": True}), 200
    except Exception as e:
        return f"An Error Occured: {e}"

@app.route('/getUser', methods = ['GET'])
def getUser():
    try:
        args = request.args
        if "authID" in args:
            data = user_ref.where("authID", "==", args["authID"]).stream()
        else:
            data = user_ref.stream()
        
        retData = [d.to_dict() for d in data]
        return jsonify(ret), 200
    except Exception as e:
        return f"An Error Occured: {e}"

# @app.route('/updateUser', methods)


        



port = int(os.environ.get('PORT', 8080))
if __name__ == '__main__':
    print("hello")
    app.run(threaded=True, host='0.0.0.0', port=port)
