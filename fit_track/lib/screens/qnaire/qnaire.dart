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
  Gender _gender = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Welcome to FitTrack!'),
      ),
      body: Container(
        color: Colors.white,
        margin: EdgeInsets.all(25),
        child: Column(
          children: [
            Text(
              'Please enter the following data:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Wrap(
              children: [
                Text(
                  'Gender:',
                  style: TextStyle(fontSize: 16),
                ),
                ListTile(
                  title: Text(
                    'Male',
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: Radio(
                    groupValue: _gender,
                    value: Gender.male,
                    onChanged: (Gender value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                    'Female',
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: Radio(
                    groupValue: _gender,
                    value: Gender.female,
                    onChanged: (Gender value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                    'Other',
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: Radio(
                    groupValue: _gender,
                    value: Gender.other,
                    onChanged: (Gender value) {
                      setState(() {
                        _gender = value;
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
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.blue)),
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
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.blue)),
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
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.blue)),
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
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.blue)),
                      hintText: 'in',
                      prefixText: ' ',
                    ),
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
                  child: Text('Done'),
                  onPressed: () {
                    widget._isCompleted();
                    Navigator.pop(context);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
