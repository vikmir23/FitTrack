import 'package:flutter/material.dart';

class JournalPage extends StatefulWidget {
  final Color color;

  JournalPage(this.color);

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  List<String> entries = [];

  String valueText = '';

  _addItem() {
    setState(() {
      entries.insert(0, valueText);
    });
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
  String name;
  String time;
  String date;
  int reps;
  Workout(
      {this.name = 'Placeholder',
      this.reps = 30,
      this.time = '00:00',
      this.date = '01/01/21'});

  printWorkout() {
    return "$reps  $name  $time  $date";
  }
}
