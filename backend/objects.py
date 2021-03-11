from datetime import *
import numpy as np


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

class Exercise:
    def __init__(self, activity, reps, intensity):
        self.activity = activity
        self.reps = reps
        self.intensity = intensity

    def getActivity(self):
        return self.activity

    def getReps(self):
        return self.reps
    
    def getIntesity(self):
        return self.intensity


'''
    userId: string,
    date: dateTime,
    activities: list of Exercises
'''
class Workout:
    def __init__(self, userId, date, activities):
        self.userId = userId
        self.date = date
        self.activities = activities
    
    def __init__(self, date, activities):
        self.userId = ""
        self.date = date
        self.activities = activities
    
    def getDate(self):
        return self.date

    def getActivities(self):
        return self.activities
    

class User:
    goals = ["Muscle-Strengthening", "Light Exercise", "Moderate Exercise"]
    def __init__(self, authId, gender, age, height, weight, goal):
        self.goals = ["Muscle-Strengthening",
                      "Light Exercise", "Moderate Exercise"]
        self.authId = authId
        self.gender = gender
        self.age = age
        self.height = height
        self.weight = weight
        self.goal = goal
        self.goalStr = self.goals[goal]
        self.workouts = []
    
    def setUserWorkouts(self, workoutsList):
        workout = []
        for w in workoutsList:
            activities = []
            act = w["activities"]
            for a in act:
                A = Exercise(a["activity"], a["reps"], a["intensity"])
                activities.append(A)
            workout.append( Workout(w["dateAdded"], activities))
        self.workouts = workout

    #get methods
    def getAuthId(self):
        return self.authId
    
    def getGender(self):
        return self.gender
    
    def getAge(self):
        return self.age

    def getHeight(self):
        return self.height

    def getWeight(self):
        return self.weight

    def getGoal(self):
        return (self.goal, self.goalStr)
    
    def getWeeksWorkouts(self):
        now = datetime.now()
        weekWorkouts = []
        for w in self.workouts:
            d = w.getDate()
            print(type(d))
            # print(w.getDate())


    '''
    Looks at previous workouts and users goal to generate 
    '''
    def getWorkoutRec(self):
        workouts = self.workouts
        week  = self.getWeeksWorkouts()
        
    
