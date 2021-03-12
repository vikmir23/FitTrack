import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pedometer/pedometer.dart';

class ProgressPage extends StatefulWidget {
  final Color color;

  ProgressPage(this.color);

  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  int segmentedControlGroupValue = 0;
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("Daily"),
    1: Text("Week"),
    2: Text("Month")
  };

  // functions provided by https://pub.dev/packages/pedometer
  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';
  String _workouts = '0';
  String _dummyStepValue = '1359';
  String _dummyWorkoutValue = '7';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Stepcount not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  void workoutError(error) {
    print('workoutError: $error');
    setState(() {
      _workouts = '0';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
              CupertinoSlidingSegmentedControl(
                  groupValue: segmentedControlGroupValue,
                  children: myTabs,
                  onValueChanged: (i) {
                    setState(() {
                      segmentedControlGroupValue = i;
                    });
                  }),
              Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
              Container(
                width: double.infinity,
                height: 500,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  color: Colors.lightGreen,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Steps taken:',
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          _dummyStepValue,
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Workouts:",
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          _dummyWorkoutValue,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
