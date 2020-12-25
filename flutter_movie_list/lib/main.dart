import 'package:flutter/material.dart';
import 'movie_list_page.dart';

void main() {
  runApp(MyMovies());
}

class MyMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Movies',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange
      ),
      home: MoviesHomePage(),
    );
  }
}

class MoviesHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MovieListPage();
  }
}

