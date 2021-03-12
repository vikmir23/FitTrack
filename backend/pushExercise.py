from firebase_admin import credentials, firestore, initialize_app

cred = credentials.Certificate('SecretKey.json')
default_app = initialize_app(cred)
db = firestore.client()
exercise_ref = db.collection(u'exercise')
fileName = "exercises.txt"
def push():
    f = open(fileName, 'r')
    count = 0
    for line in f:
        ex = dict()
        line = line.strip('\n')
        s = line.split(", ")
        ex["name"] = s[0]
        ex["muscles"] = s[1]
        exercise_ref.add(ex)
        print(count)
        count += 1

if __name__ == '__main__':
    
    push()
