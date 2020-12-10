import 'package:flutter/material.dart';
import 'package:productivity_timer/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Work Timer',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: TimerHomePage());
  }
}

class TimerHomePage extends StatelessWidget {
  final double _defaultPadding = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My work timer'),
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
                      child: ProductivityButton(color: Color(0xff009688), text: 'Work', onPressed: emptyMethod),
                    ),
                    Padding(padding: EdgeInsets.all(_defaultPadding),),
                    Expanded(child: ProductivityButton(color: Color(0xff607D8B),
                        text: "Short Break", onPressed: emptyMethod)),
                    Padding(padding: EdgeInsets.all(_defaultPadding),),
                    Expanded(child: ProductivityButton(color: Color(0xff455A64),
                        text: "Long Break", onPressed: emptyMethod)),
                    Padding(padding: EdgeInsets.all(_defaultPadding),)
                  ],
                ),
                Expanded(
                    child: CircularPercentIndicator(
                      radius: availableWidth/2,
                      lineWidth: 10.0,
                      percent: 1,
                      center: Text(
                        "30:00",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      progressColor: Color(0xff009688),
                    )
                ),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.all(_defaultPadding)),
                    Expanded(
                      child: ProductivityButton(color: Color(0xff212121), text: 'Stop', onPressed: emptyMethod),
                    ),
                    Padding(padding: EdgeInsets.all(_defaultPadding),),
                    Expanded(child: ProductivityButton(color: Color(0xff009688),
                        text: 'Restart', onPressed: emptyMethod)),
                    Padding(padding: EdgeInsets.all(_defaultPadding),),
                  ],
                )
              ],
            );
          },
        )
    );
  }

  void emptyMethod() {}
}
