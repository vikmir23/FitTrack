import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_track/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomePage extends StatelessWidget {
  final Color color;

  HomePage(this.color);

  _tempf(context) async {
    var url =
        'https://bsxd0j587l.execute-api.us-east-1.amazonaws.com/dev/user/recWorkout/' +
            Provider.of<User>(context, listen: false).uid;
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
    }
  }

  @override
  Widget build(BuildContext context) {
    _tempf(context);
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: new RichText(
              text: new TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  new TextSpan(text: 'Hello'),
                  new TextSpan(
                      text: ' User',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800])),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Recommendation",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              color: const Color(0xff020227),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                  child: Text(
                    'RECOMMENDATION',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                child: Text("Accept"),
                onPressed: null,
              ),
              SizedBox(width: 20),
              ElevatedButton(
                child: Text("Get Another Recommendation"),
                onPressed: null,
              ),
            ],
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Workout",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.topLeft,
            child: ElevatedButton(
              child: Text("Add Workout"),
              onPressed: null,
            ),
          ),
        ],
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}
