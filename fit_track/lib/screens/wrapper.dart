import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_track/models/user.dart';
import 'package:fit_track/screens/auth/auth.dart';
import 'package:fit_track/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return user == null ? Auth() : Home();
  }
}
