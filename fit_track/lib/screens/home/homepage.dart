/* This is the home screen the user sees after they log in.*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_track/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

class HomePage extends StatefulWidget {
  final Color color;

  HomePage(this.color);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var jsonResponse;
  bool isLoading = false;
  int index = 1;

  // Variables to display recommendation
  String exercise = '';
  String recReps = '';
  String recSets = '';
  String recIntensity = '';

  // Data about the workout
  String numExercises = '';
  String averageIntensity = '';
  String caloriesBurned = '435';

  // Context data (eventually sent to back-end)
  String weatherValue;
  String areaName;

  void initState() {
    super.initState();
    _getWeather();
    _getLocation();
    _tempf(context);
  }

  // HTTP request to get the recommendation from the server, sends userID
  _tempf(context) async {
    setState(() {
      isLoading = true;
    });
    var url =
        'https://bsxd0j587l.execute-api.us-east-1.amazonaws.com/dev/user/recWorkout/' +
            Provider.of<User>(context, listen: false).uid;
    while (true) {
      try {
        var response = await http.get(url);
        if (response.statusCode == 200) {
          jsonResponse = convert.jsonDecode(response.body);
          exercise = jsonResponse['activities'][0]['activity'];
          recReps = '${jsonResponse['activities'][0]['reps']}';
          recSets = '${jsonResponse['activities'][0]['sets']}';
          recIntensity = '${jsonResponse['activities'][0]['intensity']}';

          averageIntensity =
              '${jsonResponse['activities'].map((m) => m['intensity']).reduce((a, b) => a + b) / jsonResponse['activities'].length}';
          numExercises = '${jsonResponse['activities'].length}';
          break;
        }
      } catch (e) {
        continue;
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  // if the user wants a different recommendation, the next rec in ranking will be displayed
  _nextRecommendation() {
    setState(() {
      exercise = jsonResponse['activities'][index]['activity'];
      recReps = '${jsonResponse['activities'][index]['reps']}';
      recSets = '${jsonResponse['activities'][index]['sets']}';
      recIntensity = '${jsonResponse['activities'][index]['intensity']}';
      index++;
    });
  }

  // informs the recommendation system that the user accepted the recommendation displayed on screen
  _sendRectoBackEnd() async {
    var response = await http.post(
      'https://bsxd0j587l.execute-api.us-east-1.amazonaws.com/dev/workouts/addWorkout',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(<String, dynamic>{
        'userId': Provider.of<User>(context, listen: false).uid,
        'activities': [
          {
            'activity': exercise,
            'reps': int.parse(recReps),
            'sets': int.parse(recSets),
            'intensity': int.parse(recIntensity),
          }
        ]
      }),
    );
    print('Response status: ${response.statusCode}');
  }

  _getNum() {
    Random random = new Random();
    int randomNumber = random.nextInt(100) + 400;
    setState(() {
      caloriesBurned = '$randomNumber';
    });
  }

  // Weather data from openWeather API (context)
  _getWeather() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  WeatherFactory wf = new WeatherFactory("cfffe498daaa9e2eaa0f33a84ec28d07"); // GET KEY HERE
  Weather w =
      await wf.currentWeatherByLocation(position.latitude, position.longitude);
  double temp = w.temperature.fahrenheit;
  setState(() {
       weatherValue =  "$temp F";
    });
 
}

  // Location data from device itself (context)
  _getLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  WeatherFactory wf = new WeatherFactory("cfffe498daaa9e2eaa0f33a84ec28d07"); // GET KEY HERE
  Weather w =
      await wf.currentWeatherByLocation(position.latitude, position.longitude);
  setState(() {
       areaName =  w.areaName;
    });
}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: new RichText(
              text: new TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  new TextSpan(text: 'Hello'),
                  new TextSpan(
                      text: ' User',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800])),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Recommendation",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              color: const Color(0xff020227),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Column(
                          children: [
                            Text(
                              exercise,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Reps: $recReps',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Sets: $recSets',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Intensity: $recIntensity',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                child: Text("Accept"),
                onPressed: _sendRectoBackEnd,
              ),
              SizedBox(width: 20),
              ElevatedButton(
                child: Text("Get Next Recommendation"),
                onPressed: () {
                  _nextRecommendation();
                  _getNum();
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Current Workout Data",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Number of exercises: $numExercises',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Average Intensity: $averageIntensity',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Calories burned: $caloriesBurned',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Context",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Location: $areaName',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Weather: $weatherValue',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}




