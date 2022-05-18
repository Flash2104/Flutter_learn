import 'package:flutter/material.dart';
import 'package:flutter_layouts/widgets/main/button-section.dart';
import 'package:flutter_layouts/widgets/main/text-section.dart';
import 'package:flutter_layouts/widgets/main/title-section.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<void> onPressedButton(BuildContext context, String lable) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(lable),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You trying to $lable'),
                const Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layouts Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter layouts Demo'),
        ),
        body: Card(
            margin: const EdgeInsets.all(10),
            // decoration: BoxDecoration(
            //     border: Border.all(color: Colors.black),
            //     borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: ListView(
              children: [
                Image.asset('assets/images/lake.png',
                    width: 600, height: 240, fit: BoxFit.cover),
                const TitleSection(),
                ButtonSection(callbackFunc: onPressedButton),
                const TextSection()
              ],
            )),
      ),
    );
  }
}
