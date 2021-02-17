import 'package:flutter/material.dart';
import 'package:fit_track/models/user.dart';
import 'package:fit_track/screens/wrapper.dart';
import 'package:fit_track/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: authService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
