import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final Color color;

  SettingsPage(this.color);

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
                'Reset Data',
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
