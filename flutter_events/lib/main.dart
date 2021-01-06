import 'package:flutter/material.dart';
import 'package:flutter_events/screens/launch_screen.dart';

void main() {
  runApp(MainWidget());
}

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.orange),
      title: 'Events',
      home: LaunchScreen()
    );
  }
}



