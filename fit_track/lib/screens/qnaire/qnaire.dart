/* Implementation of the new user form screen */

import 'package:fit_track/screens/home/home.dart';
import 'package:fit_track/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:fit_track/models/user.dart';

enum Gender { male, female, other }

// New user questionnaire (actually just a form)
class Qnaire extends StatefulWidget {
  // final Function _isCompleted;

  // Qnaire(this._isCompleted);

  @override
  _QnaireState createState() => _QnaireState();
}

class _QnaireState extends State<Qnaire> {
  String genderValue = 'Other';
  String goalValue = 'Moderate Exercise';
  int ageValue = 0;
  int weightValue = 0;
  int heightValue = 0;
  List<String> goals = <String>[
    'Muscle-Strengthening',
    'Light Exercise',
    'Moderate Exercise'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Welcome to FitTrack!'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.all(25),
          child: Column(
            children: [
              Text(
                'Please enter the following data:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Gender:    ',
                    style: TextStyle(fontSize: 16),
                  ),
                  Container(
                    height: 50,
                    width: 80,
                    child: DropdownButton<String>(
                      value: genderValue,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 20,
                      elevation: 16,
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                      underline: Container(
                        height: 2,
                        color: Colors.blue,
                      ),
                      items: <String>['Male', 'Female', 'Other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          genderValue = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Age:    ',
                    style: TextStyle(fontSize: 16),
                  ),
                  Container(
                    width: 100,
                    child: TextField(
                      decoration: new InputDecoration(
                        enabledBorder: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.blue, width: 2)),
                        hintText: '',
                        prefixText: ' ',
                      ),
                      onChanged: (value) {
                        ageValue = int.parse(value);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Weight:    ',
                    style: TextStyle(fontSize: 16),
                  ),
                  Container(
                    width: 100,
                    child: TextField(
                      decoration: new InputDecoration(
                        enabledBorder: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.blue, width: 2)),
                        hintText: 'lb',
                        prefixText: ' ',
                      ),
                      onChanged: (value) {
                        weightValue = int.parse(value);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Height:    ',
                    style: TextStyle(fontSize: 16),
                  ),
                  Container(
                    width: 100,
                    child: TextField(
                      decoration: new InputDecoration(
                        enabledBorder: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.blue, width: 2)),
                        hintText: 'ft',
                        prefixText: ' ',
                      ),
                      onChanged: (value) {
                        heightValue = int.parse(value);
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 100,
                    child: TextField(
                      decoration: new InputDecoration(
                        enabledBorder: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.blue, width: 2)),
                        hintText: 'in',
                        prefixText: ' ',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Goal:    ',
                    style: TextStyle(fontSize: 16),
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    child: DropdownButton<String>(
                      value: goalValue,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 20,
                      elevation: 16,
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                      underline: Container(
                        height: 2,
                        color: Colors.blue,
                      ),
                      items:
                          goals.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          goalValue = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                    child: Text(
                      'Done',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () async { // sends input data to back-end and creates the user's personal profile in the system
                      var response = await http.post(
                        'https://bsxd0j587l.execute-api.us-east-1.amazonaws.com/dev/user/addUser',
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(<String, dynamic>{
                          'authId':
                              Provider.of<User>(context, listen: false).uid,
                          'gender': genderValue,
                          'age': ageValue,
                          'height': heightValue,
                          'weight': weightValue,
                          'goal': goals.indexOf(goalValue),
                        }),
                      );
                      print('Response status: ${response.statusCode}');
                      print('Response body: ${response.body}');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Wrapper()));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
