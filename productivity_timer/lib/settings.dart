import 'package:flutter/material.dart';
import 'package:productivity_timer/widgets.dart';

class TimerSettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TimerSettingsState();
  }
}

class _TimerSettingsState extends State<TimerSettingsPage> {
  final TextStyle _textStyle = TextStyle(fontSize: 24);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Container(
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            padding: const EdgeInsets.all(20),
            children: [
              Text('Work', style: _textStyle),
              Text('1'),
              Text('2'),
              SettingsButton(Color(0xff455A64), '-', -1),
              TextField(style: _textStyle,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number),
              SettingsButton(Color(0xff009688), '+', 1),
              Text('Short', style: _textStyle),
              Text('3'),
              Text('4'),
              SettingsButton(Color(0xff455A64), "-", -1, ),
              TextField(
                  style: _textStyle,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number),
              SettingsButton(Color(0xff009688), "+", 1),
              Text("Long", style: _textStyle),
              Text(""),
              Text(""),
              SettingsButton(Color(0xff455A64), "-", -1,),
              TextField(
                  style: _textStyle,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number),
              SettingsButton(Color(0xff009688), "+", 1,),
            ],
          )),
    );
  }
}
