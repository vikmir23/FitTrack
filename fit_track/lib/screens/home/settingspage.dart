// Settings screen. The only option implemented here is 'Reset Data'.
// If the user taps the button then their recorded workouts will be deleted 
// and the recommendation engine will start from zero just for them.

import 'package:flutter/material.dart';
import 'package:fit_track/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  final Color color;

  SettingsPage(this.color);

  _wipeData(context) async {
    var response = await http.post(
      'https://bsxd0j587l.execute-api.us-east-1.amazonaws.com/dev',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(<String, dynamic>{
        'userId': Provider.of<User>(context, listen: false).uid,
        'wipe': true,
      }),
    );
    print('Response status: ${response.statusCode}');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30),
            child: ElevatedButton(
              onPressed: () {
                _wipeData(context);
              },
              child: Text(
                'Reset Data',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}
