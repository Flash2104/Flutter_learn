import 'package:flutter/material.dart';

void main() {
  runApp(MainWidget());
}

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.orange),
      title: 'Events',
      home: Scaffold(
        appBar: AppBar(title: Text('Events')),
        body: MainBodyView(),
      )
    );
  }
}

class MainBodyView extends StatefulWidget {
  @override
  _MainBodyViewState createState() => _MainBodyViewState();
}

class _MainBodyViewState extends State<MainBodyView> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('События тут'),);
  }
}


