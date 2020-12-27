import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colored_progress_indicators/flutter_colored_progress_indicators.dart';
import 'package:flutter_movie_list/models/movie_dto.dart';
import 'package:http/http.dart' as http;

class MovieHttpService {
  final String _urlApiKey = '?api_key=c7d7585faad21b08a085bd6dde6cf0ce';
  final String _urlBase = 'https://api.themoviedb.org/3/movie';
  final String _urlUpcoming = '/upcoming';
  final String _urlLanguage = '&language=ru-RU';

  final String _imgOriginalBase = 'https://image.tmdb.org/t/p/original';
  final String _img500Base='https://image.tmdb.org/t/p/w500/';
  final String _defaultImage = 'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  Future<MovieListDto> getUpcoming() async {
    final String upcoming = _urlBase + _urlUpcoming + _urlApiKey + _urlLanguage;
    http.Response result = await http.get(upcoming);
    if (result.statusCode == HttpStatus.ok) {
      String responseBody = result.body;
      final jsonResponse = json.decode(responseBody);
      final movieMap = jsonResponse['results'] as Iterable;
      final movieList = MovieListDto(
          movies: movieMap?.map((e) => MovieDto.fromJson(e))?.toList(),
          currentPage: jsonResponse['page'],
          totalPages: jsonResponse['total_pages'],
          totalResults: jsonResponse['total_results']);
      return movieList;
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
