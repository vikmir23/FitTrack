import 'package:flutter/material.dart';

class ProgressPage extends StatelessWidget {
  final Color color;

  ProgressPage(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
