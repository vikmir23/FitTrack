import 'package:flutter/material.dart';

enum Gender { male, female, other }

// New user questionnaire (actually just a form)
class Qnaire extends StatefulWidget {
  final Function _isCompleted;

  Qnaire(this._isCompleted);

  @override
  _QnaireState createState() => _QnaireState();
}

class _QnaireState extends State<Qnaire> {
  String genderValue = 'Other';
  String goalValue = 'Moderate Exercise';

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
                      items: <String>[
                        'Muscle-Strengthening',
                        'Light Exercise',
                        'Moderate Exercise'
                      ].map<DropdownMenuItem<String>>((String value) {
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
                child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text(
                      'Done',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      widget._isCompleted();
                      Navigator.pop(context);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
