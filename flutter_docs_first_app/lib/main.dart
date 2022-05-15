import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_docs_first_app/widgets/gesture-button.dart';

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
          body: Column(children: const [
            Center(child: GestureButton()),
            SizedBox(height: 600, child: RandomWords())
          ]),
          floatingActionButton: const FloatingActionButton(
              onPressed: null, child: Icon(Icons.add)),
        ));
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RandomWordsState();
  }
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: /*1*/ (context, index) {
        if (index.isOdd) {
          return const Divider(); /*2*/
        }
        final i = index ~/ 2; /*3*/
        if (i >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/
        }
        return ListTile(
            title: Text(_suggestions[i].asPascalCase, style: _biggerFont));
      },
    );
  }
}
