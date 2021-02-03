import 'package:fit_track/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final authService _auth = authService();
  void signout() async {
    await _auth.signout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Text("Contact Tracing"),
        backgroundColor: Colors.blueGrey[400],
        actions: [
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text("Signout"),
            onPressed: signout,
          )
        ],
      ),
    );
  }
}
