/* Home.dart is the backbone of every screen in FitTrack after the user logs in.
Here, the app's header and navigation bar are implemented.*/

import 'package:fit_track/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fit_track/screens/qnaire/qnaire.dart';
import 'package:provider/provider.dart';


import 'homepage.dart';
import 'journalpage.dart';
import 'progresspage.dart';
import 'settingspage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0; // controls which screen is displayed as the user navigates the app
  bool justLoggedIn = true;
  final List<Widget> _children = [
    HomePage(Colors.blue),
    JournalPage(Colors.white), 
    ProgressPage(Colors.lightGreen), 
    SettingsPage(Colors.grey), 
  ];
  final _appBarText = [
    'Home',
    'Journal',
    'Progress',
    'Settings',
  ];
  final authService _auth = authService();
  var isNewUser = false; 

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
      justLoggedIn = false;
    }
    return Scaffold(
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
    );
  }
}
