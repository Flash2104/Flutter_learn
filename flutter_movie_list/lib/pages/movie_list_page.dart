import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_list/models/movie_dto.dart';
import 'package:flutter_movie_list/pages/movie_detail_page.dart';
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
  final String _iconBase = 'https://image.tmdb.org/t/p/original';
  final String _defaultImage = 'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

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
          ? Center(
              child: ColoredCircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _moviesCount,
              cacheExtent: 1000,
              itemBuilder: (BuildContext context, int index) {
                MovieDto item = _movieList.movies[index];
                CachedNetworkImage image = this._httpService.getOriginalImage(item.posterPath);
                return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    title: Text(item.title),
                    onTap: () => _goToDetail(item),
                    subtitle: Text('В прокате: ${item.releaseDate} | Средняя оценка: ${item.voteAverage}'),
                    leading: image,
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

  void _goToDetail(MovieDto movieDto) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => MovieDetailPage(movieDto));
    Navigator.push(context, route);
  }
}
