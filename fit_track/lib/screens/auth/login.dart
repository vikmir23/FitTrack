import 'package:fit_track/services/auth.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final authService _auth = authService();

  String email = "";
  String password = "";
  String error = "";

  void signInEmail() async {
    dynamic userResult = await _auth.signInWithEmail(email, password);
    if (userResult == null) {
      setState(() => error = "invalid credentials");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in'),
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
                signInEmail();
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
