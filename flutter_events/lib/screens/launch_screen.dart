import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_events/shared/auth.dart';

import 'event_screen.dart';
import 'login_screen.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().then((value) {
      Authentication auth = Authentication();
      auth.getUser().then((user) {
        MaterialPageRoute route;
        if (user != null) {
          route = MaterialPageRoute(builder: (context) =>
              EventScreen());
        }
        else {
          route = MaterialPageRoute(builder: (context) =>
              LoginScreen());
        }
        Navigator.pushReplacement(context, route);
      }).catchError((err)=> print(err));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
