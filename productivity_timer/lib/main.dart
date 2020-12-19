import 'package:flutter/material.dart';
import 'package:productivity_timer/settings.dart';
import 'package:productivity_timer/timer.dart';
import 'package:productivity_timer/timermodel.dart';
import 'package:productivity_timer/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Work Timer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: TimerHomePage());
  }
}

class TimerHomePage extends StatelessWidget {
  final double _defaultPadding = 5.0;
  final CountDownTimer _timer = CountDownTimer();
  final List<PopupMenuItem<String>> _menuItems = List.of([PopupMenuItem(child: Text('Settings'), value: 'Settings')], growable: false);

  @override
  Widget build(BuildContext context) {
    _timer.startWork();
    return Scaffold(
        appBar: AppBar(
          title: Text('My work timer'),
          actions: [
            PopupMenuButton<String>(
                itemBuilder: (context) => _menuItems,
                onSelected: (s) {
                  if (s == 'Settings') {
                    this._goToSettings(context);
                  }
                })
          ],
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double availableWidth = constraints.maxWidth;
            return Column(
              children: [
                Row(
                  children: [
                    Padding(padding: EdgeInsets.all(_defaultPadding)),
                    Expanded(
                      child: ProductivityButton(color: Color(0xff009688), text: 'Work', onPressed: _timer.startWork),
                    ),
                    Padding(
                      padding: EdgeInsets.all(_defaultPadding),
                    ),
                    Expanded(child: ProductivityButton(color: Color(0xff607D8B), text: "Short Break", onPressed: () => _timer.startBreak(true))),
                    Padding(
                      padding: EdgeInsets.all(_defaultPadding),
                    ),
                    Expanded(child: ProductivityButton(color: Color(0xff455A64), text: "Long Break", onPressed: () => _timer.startBreak(false))),
                    Padding(
                      padding: EdgeInsets.all(_defaultPadding),
                    )
                  ],
                ),
                Expanded(
                    child: StreamBuilder(
                  initialData: 'init',
                  stream: _timer.stream(),
                  builder: (context, snapshot) {
                    TimerModel model = (snapshot.data == 'init') ? TimerModel('00:00', 1) : snapshot.data;
                    return CircularPercentIndicator(
                      radius: availableWidth / 2,
                      lineWidth: 10.0,
                      percent: model.percent,
                      center: Text(
                        model.time,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      progressColor: Color(0xff009688),
                    );
                  },
                )),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.all(_defaultPadding)),
                    Expanded(
                      child: ProductivityButton(color: Color(0xff212121), text: 'Stop', onPressed: _timer.stopTimer),
                    ),
                    Padding(
                      padding: EdgeInsets.all(_defaultPadding),
                    ),
                    Expanded(child: ProductivityButton(color: Color(0xff009688), text: 'Start', onPressed: _timer.startTimer)),
                    Padding(
                      padding: EdgeInsets.all(_defaultPadding),
                    ),
                  ],
                )
              ],
            );
          },
        ));
  }

  void _goToSettings(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TimerSettingsPage();
    }));
  }

  void emptyMethod() {}
}
