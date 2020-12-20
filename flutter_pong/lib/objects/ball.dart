import 'package:flutter/material.dart';

class BallObject extends StatelessWidget {
  final double _diameter = 50;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _diameter,
      height: _diameter,
      decoration: BoxDecoration(
        color: Colors.amber[600],
        shape: BoxShape.circle
      ),
    );
  }
}