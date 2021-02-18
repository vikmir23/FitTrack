import 'package:flutter/material.dart';

class ProgressPage extends StatelessWidget {
  final Color color;

  ProgressPage(this.color);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30),
            child: const ElevatedButton(
              onPressed: null,
              child: Text(
                'View Today\'s Summary',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: const ElevatedButton(
              onPressed: null,
              child: Text(
                'View This Week\'s Summary',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: const ElevatedButton(
              onPressed: null,
              child: Text(
                'View This Month\'s Summary',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}
