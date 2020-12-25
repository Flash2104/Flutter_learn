import 'package:flutter/material.dart';
import 'package:flutter_movie_list/models/movie_dto.dart';
import '../services/movie_http.service.dart';
import 'package:flutter_colored_progress_indicators/flutter_colored_progress_indicators.dart';

class MovieListPage extends StatefulWidget {
  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  MovieHttpService _httpService;
  MovieListDto _movieList;
  int _moviesCount = 0;

  @override
  void initState() {
    _httpService = MovieHttpService();
    this._initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movies')),
      body: _movieList?.movies == null
          ? Center(child: ColoredCircularProgressIndicator(),)
          : ListView.builder(
        itemCount: _moviesCount,
        itemBuilder: (BuildContext context, int index) {
          var item = _movieList.movies[index];
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              title: Text(item.title),
              subtitle: Text('В прокате: ${item.releaseDate} | Средняя оценка: ${item.voteAverage}'),
            ),
          );
        },
      ),
    );
  }

  Future _initialize() async {
    var movieList = await _httpService.getUpcoming();
    setState(() {
      _movieList = movieList;
      _moviesCount = _movieList?.movies?.length ?? 0;
    });
  }
}
