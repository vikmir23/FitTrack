import 'package:flutter/material.dart';
import 'package:fit_track/screens/auth/register.dart';
import 'package:fit_track/screens/auth/login.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('FitTrack'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text("Sign in"),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => login()));
              },
            ),
            SizedBox(width: 20),
            ElevatedButton(
              child: Text("Get Started"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => register()));
              },
            ),
          ],
        ),
      ),
    );
    // return Container(
    //   child: Row(
    //     children: <Widget>[
    //       ElevatedButton(
    //         child: Text("Sign in"),
    //         onPressed: () {
    //           Navigator.push(
    //               context, MaterialPageRoute(builder: (context) => login()));
    //         },
    //       ),
    //       ElevatedButton(
    //         child: Text("Get Started"),
    //         onPressed: () {
    //           Navigator.push(
    //               context, MaterialPageRoute(builder: (context) => register()));
    //         },
    //       ),
    //     ],
    //   ),
    // );
  }
}
