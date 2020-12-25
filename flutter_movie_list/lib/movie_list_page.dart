import 'package:flutter/material.dart';
import 'package:flutter_movie_list/movie_http.service.dart';

class MovieListPage extends StatefulWidget {
  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  MovieHttpService _httpService;

  @override
  void initState() {
    _httpService = MovieHttpService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String resultJson;
    _httpService.getUpcoming().then((value) {
      setState(() {
        resultJson = value;
      });
    });
    return Scaffold(
      appBar: AppBar(title: Text('Movies')),
      body: Container(
        child: Text(resultJson)
      ),
    );
  }
}
