import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  RandomWordsState createState() {
    return RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _likedIndexes = <int>[];
  final _biggerFont = const TextStyle(fontSize: 18);

  void _handleLiked(int index) {
    setState(() {
      if (_likedIndexes.contains(index)) {
        _likedIndexes.remove(index);
      } else {
        _likedIndexes.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        if (index.isOdd) {
          return const Divider(thickness: 2);
        }
        final i = index ~/ 2;
        if (i >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/
        }
        return ListTile(
          key: Key(_suggestions[i].hashCode.toString()),
          title: Text(_suggestions[i].asPascalCase, style: _biggerFont),
          trailing: _likedIndexes.contains(index) ? IconButton(
              onPressed: () => _handleLiked(index),
              icon: const Icon(Icons.favorite, color: Colors.red)) :
          IconButton(
              onPressed: () => _handleLiked(index),
              icon: const Icon(Icons.favorite_border))
        );
      },
    );
  }
}
