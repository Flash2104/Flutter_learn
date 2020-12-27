import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colored_progress_indicators/flutter_colored_progress_indicators.dart';
import 'package:flutter_movie_list/models/movie_dto.dart';
import 'package:http/http.dart' as http;

class MovieHttpService {
  final String _urlApiKey = '?api_key=c7d7585faad21b08a085bd6dde6cf0ce';
  final String _urlBase = 'https://api.themoviedb.org/3';
  final String _urlMovie = '/movie';
  final String _urlGenre = '/genre';
  final String _urlSearch = '/search';
  final String _urlList = '/list';
  final String _urlUpcoming = '/upcoming';
  final String _urlLanguage = '&language=ru-RU';
  final String _urlQuery = '&query=';

  final String _urlSearchBase = 'https://api.themoviedb.org/3/search/movie?api_key=c7d7585faad21b08a085bd6dde6cf0ce&query=';

  final String _imgOriginalBase = 'https://image.tmdb.org/t/p/original';
  final String _img500Base='https://image.tmdb.org/t/p/w500/';
  final String _defaultImage = 'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  Future<MovieListDto> getUpcoming() async {
    final String upcoming = _urlBase + _urlMovie + _urlUpcoming + _urlApiKey + _urlLanguage;
    http.Response result = await http.get(upcoming);
    if (result.statusCode == HttpStatus.ok) {
      String responseBody = result.body;
      final jsonResponse = json.decode(responseBody);
      final moviesResult = jsonResponse['results'] as Iterable;
      final movieList = MovieListDto(
          movies: moviesResult,
          currentPage: jsonResponse['page'],
          totalPages: jsonResponse['total_pages'],
          totalResults: jsonResponse['total_results']);
      return movieList;
    } else {
      return null;
    }
  }

  Future<MovieListDto> findMovies(String query) async {
    final String url = _urlBase +_urlSearch + _urlMovie + _urlApiKey +_urlQuery + query + _urlLanguage;
    var response = await http.get(url);
    if(response.statusCode == HttpStatus.ok) {
      var jsonMap = json.decode(response.body);
      var moviesResult = jsonMap['results'] as Iterable;
      final movieList = MovieListDto(
          movies: moviesResult,
          currentPage: jsonMap['page'],
          totalPages: jsonMap['total_pages'],
          totalResults: jsonMap['total_results']);
      return movieList;
    } else {
      return null;
    }
  }

  Future<Map<int, String>> getGenres() async {
    final String url = _urlBase + _urlGenre + _urlMovie + _urlList + _urlApiKey + _urlLanguage;
    var response = await http.get(url);
    if(response.statusCode == HttpStatus.ok) {
      var jsonMap = json.decode(response.body);
      var genresResult = jsonMap['genres'] as Iterable;
      final genreMap = Map<int, String>.fromIterable(genresResult, key: (element) => element['id'], value: (element) => element['name']);
      return genreMap;
    } else {
      return null;
    }
  }

  CachedNetworkImage getOriginalImage(String path) {
    CachedNetworkImage image;
    if (path != null) {
      image = CachedNetworkImage(
        imageUrl: _imgOriginalBase + path,
        errorWidget: (context, url, error) => Icon(Icons.error),
        placeholder: (context, url) => ColoredCircularProgressIndicator(),
      );
    } else {
      image = CachedNetworkImage(
        imageUrl: _defaultImage,
        errorWidget: (context, url, error) => Icon(Icons.error),
        placeholder: (context, url) => ColoredCircularProgressIndicator(),
      );
    }
    return image;
  }

  CachedNetworkImage get500Image(String path) {
    CachedNetworkImage image;
    if (path != null) {
      image = CachedNetworkImage(
        imageUrl: _img500Base + path,
        errorWidget: (context, url, error) => Icon(Icons.error),
        placeholder: (context, url) => ColoredCircularProgressIndicator(),
      );
    } else {
      image = CachedNetworkImage(
        imageUrl: _defaultImage,
        errorWidget: (context, url, error) => Icon(Icons.error),
        placeholder: (context, url) => ColoredCircularProgressIndicator(),
      );
    }
    return image;
  }
}
