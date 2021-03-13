import 'package:fit_track/screens/qnaire/qnaireFirst.dart';
import 'package:fit_track/services/auth.dart';
import 'package:flutter/material.dart';

class register extends StatefulWidget {
  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  final authService _auth = authService();

  String email = "";
  String password = "";
  String error = "";

  void registerWithEmail() async {
    dynamic result = await _auth.registerEmail(email, password);
    if (result == null) {
      setState(() => error = "error signing up");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        child: Form(
            child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                icon: null,
                hintText: "",
                labelText: "email",
              ),
              onChanged: (val) {
                setState(() => email = val);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: null,
                hintText: "",
                labelText: "password",
              ),
              obscureText: true,
              onChanged: (val) {
                setState(() => password = val);
              },
            ),
            ElevatedButton(
              child: Text(
                "Register with email",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                registerWithEmail();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QnaireFirst()));
              },
            ),
            ElevatedButton(
              child: Text(
                "Back",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        )),
      ),
    );
  }
}
