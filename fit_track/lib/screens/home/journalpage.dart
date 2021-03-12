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
  List<String> entries = [];
  List<Workout> workouts = [Workout(), Workout()];

  String valueText = '';

  _addItem() {
    setState(() {
      entries.insert(0, valueText);
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
        'activities': workouts,
      }),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Entry'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              decoration:
                  InputDecoration(hintText: "Reps - Exercise - Time - Date"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    valueText = '';
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    if (valueText != '') {
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
    print(jsonEncode(<String, dynamic>{
        'userId': Provider.of<User>(context, listen: false).uid,
        'activities': workouts,
      }));
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
                  child: Text("Add Workout"),
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
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(0),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: Center(child: Text(entries[index])),
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
    return "$activity  $reps  $sets  $intensity";
  }

  Map<String, dynamic> toJson() => {
        'activity': activity,
        'reps': int.parse(reps),
        'sets': int.parse(sets),
        'intensity': int.parse(intensity),
      };
}
