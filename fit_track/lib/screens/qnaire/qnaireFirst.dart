/* Welcome to Fittrack screen. This is the screen shown to the user as soon as they create an account */

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:fit_track/models/user.dart';
import 'package:fit_track/screens/qnaire/qnaire.dart';

class QnaireFirst extends StatefulWidget {
  @override
  _QnaireFirstState createState() => _QnaireFirstState();
}

class _QnaireFirstState extends State<QnaireFirst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to FitTrack!',
              style: TextStyle(
                fontSize: 32,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            Text(
              'FitTrack is a recommendation app designed to enhance your physical health. To start enjoying the experience, we would like to ask you a few questions.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 80),
            Container(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text(
                  'Take Questionnaire',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Qnaire()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
