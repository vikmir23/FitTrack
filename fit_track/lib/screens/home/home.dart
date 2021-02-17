import 'package:fit_track/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fit_track/screens/qnaire/qnaire.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final authService _auth = authService();
  var isNewUser = true; // change this to False to debug home page faster

  void signout() async {
    await _auth.signout();
  }

  void _completed() {
    setState(() {
      isNewUser = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isNewUser == false // If user is NOT new then display New User form else just home screen
        ? Scaffold(
            backgroundColor: Colors.blueGrey[100],
            appBar: AppBar(
              title: Text("Home"),
              centerTitle: true,
              backgroundColor: Colors.blueGrey[400],
              actions: [
                TextButton.icon(
                  icon: Icon(Icons.person),
                  label: Text("Sign out"),
                  onPressed: signout,
                )
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: 'Journal',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.fitness_center),
                  label: 'Progress',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                )
              ],
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              margin: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to FitTrack!',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.blue,
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
                      child: Text('Take Questionnaire'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Qnaire(_completed)));
                      },
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
