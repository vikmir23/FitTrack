import 'package:fit_track/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fit_track/screens/qnaire/qnaire.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

import 'homepage.dart';
import 'journalpage.dart';
import 'progresspage.dart';
import 'settingspage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  bool justLoggedIn = true;
  final List<Widget> _children = [
    HomePage(Colors.blue), // place holder color
    JournalPage(Colors.white), // place holder color
    ProgressPage(Colors.lightGreen), // place holder color
    SettingsPage(Colors.grey), // place holder color
  ];
  final _appBarText = [
    'Home',
    'Journal',
    'Progress',
    'Settings',
  ];
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

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (justLoggedIn) {
      _getContextData();
      justLoggedIn = false;
    }
    return isNewUser ==
            false // If user is NOT new then display New User form else just home screen
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(_appBarText[_currentIndex]),
              // title: Text("Home"),
              centerTitle: true,
              backgroundColor: Colors.green[400],
              actions: [
                TextButton.icon(
                  icon: Icon(Icons.person, color: Colors.white),
                  label: Text(
                    "Sign out",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: signout,
                )
              ],
            ),
            body: _children[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              fixedColor: Colors.green[400],
              onTap: onTabTapped,
              currentIndex: _currentIndex,
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
              backgroundColor: Colors.grey[150],
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

void _getContextData() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  WeatherFactory wf = new WeatherFactory("cfffe498daaa9e2eaa0f33a84ec28d07");
  Weather w =
      await wf.currentWeatherByLocation(position.latitude, position.longitude);
  double temp = w.temperature.fahrenheit;
  print("Temperature: $temp Fahrenheit");

  DateTime now = DateTime.now();
  print("Time: " +
      now.hour.toString() +
      ":" +
      now.minute.toString() +
      ":" +
      now.second.toString());
}
