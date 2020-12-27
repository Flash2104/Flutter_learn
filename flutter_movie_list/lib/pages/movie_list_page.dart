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
  Map<int, String> _genreMap;
  int _moviesCount = 0;

  Icon _visibleIcon = Icon(Icons.search);
  Widget _appBar = Text('Movie List');

  @override
  void initState() {
    _httpService = MovieHttpService();
    this._initialize();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBar,
        actions: [
          IconButton(
            icon: _visibleIcon,
            onPressed: () {
              setState(() {
                if (_visibleIcon.icon == Icons.search) {
                  _visibleIcon = Icon(Icons.cancel);
                  _appBar = TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) => this._searchMovies(value),
                    autofocus: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  );
                } else {
                  _visibleIcon = Icon(Icons.search);
                  _appBar = Text('Movie List');
                }
              });
            },
          )
        ],
      ),
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
                var genreList = item.genreList.map((e) => _genreMap[e]).toList();
                return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                      title: Text(item.title),
                      onTap: () => _goToDetail(item),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text('В прокате: ${item.releaseDate}'),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text('Средняя оценка: ${item.voteAverage}'),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text('Жанр: ${genreList.join(", ")}', style: TextStyle(color: Colors.lightBlue),),
                              )
                            ],
                          ),
                        ],
                      ),
                      leading: image),
                );
              },
            ),
    );
  }

  Future _initialize() async {
    var movieList = await _httpService.getUpcoming();
    var genreMap = await _httpService.getGenres();
    setState(() {
      _movieList = movieList;
      _genreMap = genreMap ?? Map<int, String>();
      _moviesCount = _movieList?.movies?.length ?? 0;
    });
  }

  void _goToDetail(MovieDto movieDto) {
    var genreList = movieDto.genreList.map((e) => _genreMap[e]).toList();
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => MovieDetailPage(movieDto, genreList));
    Navigator.push(context, route);
  }

  Future _searchMovies(String query) async {
    var movieList = await _httpService.findMovies(query);
    setState(() {
      _moviesCount = movieList?.movies?.length ?? 0;
      _movieList = movieList;
    });
  }
}
