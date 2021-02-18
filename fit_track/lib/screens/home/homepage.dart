import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Color color;

  HomePage(this.color);

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
                'Add workout',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: const ElevatedButton(
              onPressed: null,
              child: Text(
                'Update information',
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
