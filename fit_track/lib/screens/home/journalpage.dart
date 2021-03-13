import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:fit_track/models/user.dart';


class JournalPage extends StatefulWidget {
  final Color color;

  JournalPage(this.color);

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  bool isLoading = false;
  List<Workout> entries = [];
  List<Workout> workouts = [];

  String inputActivity = '';
  String inputReps = '';
  String inputSets = '';
  String inputIntensity = '';

  void initState() {
    super.initState();
    _loadJournal(context);
  }

  _addItem() {
    setState(() {
      workouts.insert(
          0,
          Workout(
            activity: inputActivity,
            reps: inputReps,
            sets: inputSets,
            intensity: inputIntensity,
          ));
      entries.add(Workout(
        activity: inputActivity,
        reps: inputReps,
        sets: inputSets,
        intensity: inputIntensity,
      ));
    });
  }

  _workoutToBackEnd() async {
    var response = await http.post(
      'https://bsxd0j587l.execute-api.us-east-1.amazonaws.com/dev/workouts/addWorkout',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': Provider.of<User>(context, listen: false).uid,
        'activities': [
          {
            'activity': inputActivity,
            'reps': inputReps,
            'sets': inputSets,
            'intensity': inputIntensity,
          }
        ],
      }),
    );
    print('Response status: ${response.statusCode}');
  }

  _loadJournal(context) async {
    setState(() {
      isLoading = true;
    });
    var url =
        'https://bsxd0j587l.execute-api.us-east-1.amazonaws.com/dev/workouts/user/' +
            Provider.of<User>(context, listen: false).uid;
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List;
      for (var i = 0; i < jsonResponse.length; i++) {
        for (var j = 0; j < jsonResponse[i]['activities'].length; j++) {
          Workout w = Workout(
            activity: jsonResponse[i]['activities'][j]['activity'],
            reps: '${jsonResponse[i]['activities'][j]['reps']}',
            sets: '${jsonResponse[i]['activities'][j]['sets']}',
            intensity: '${jsonResponse[i]['activities'][j]['intensity']}',
          );
          workouts.insert(0, w);
        }
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Entry'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        inputActivity = value;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: "Activity - Ex: Shoulder press"),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        inputReps = value;
                      });
                    },
                    decoration: InputDecoration(hintText: "Reps - Ex: 60"),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        inputSets = value;
                      });
                    },
                    decoration: InputDecoration(hintText: "Sets - Ex: 3"),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        inputIntensity = value;
                      });
                    },
                    decoration:
                        InputDecoration(hintText: "Intensity - Ex: 8 (Heavy)"),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    inputActivity = '';
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    if (inputActivity != '') {
                      _addItem();
                    }
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Entries",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  child: Text("Send Data to DB"),
                  onPressed: () {
                    _workoutToBackEnd();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  child: Text("Add Entry"),
                  onPressed: () {
                    _displayTextInputDialog(context);
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(0),
                    itemCount: workouts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        color: Colors.amber[500],
                        child: Center(
                            child: Text(
                          workouts[index].printWorkout(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ),
        ],
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}

class Workout {
  String activity;
  String reps;
  String sets;
  String intensity;
  Workout(
      {this.activity = 'Placeholder',
      this.reps = "30",
      this.sets = "3",
      this.intensity = "8"});

  printWorkout() {
    return "$activity   R: $reps  S: $sets  I: $intensity";
  }

  Map<String, dynamic> toJson() => {
        'activity': activity,
        'reps': int.parse(reps),
        'sets': int.parse(sets),
        'intensity': int.parse(intensity),
      };
}
