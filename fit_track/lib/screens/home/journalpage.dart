import 'package:flutter/material.dart';

class JournalPage extends StatelessWidget {
  final Color color;

  JournalPage(this.color);

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
                'Add New Entry',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: const ElevatedButton(
              onPressed: null,
              child: Text(
                'View/Edit previous entries',
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
