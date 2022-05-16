import 'dart:developer';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_docs_first_app/widgets/counter.dart';
import 'package:flutter_docs_first_app/widgets/gesture-button.dart';
import 'package:flutter_docs_first_app/widgets/random-words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Startup Name Generator',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: Scaffold(
          appBar: AppBar(
            leading: const IconButton(onPressed: null, icon: Icon(Icons.menu)),
            title: const Text('Startup Name Generator'),
            actions: const [
              IconButton(icon: Icon(Icons.search), onPressed: null)
            ],
          ),
          body: Column(children: [
            const Center(child: Counter()),
            // Center(child: GestureButton()),
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        // color: Colors.black,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.black)),
                    // constraints: BoxConstraints.expand(),
                    child: const RandomWords()))
          ]),
          // floatingActionButton: const FloatingActionButton(
          //     onPressed: null, child: Icon(Icons.add)),
        ));
  }
}
