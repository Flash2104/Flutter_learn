import 'dart:convert';
import 'dart:io';
import 'package:flutter_movie_list/models/movie_dto.dart';
import 'package:http/http.dart' as http;

class MovieHttpService {
  final String _urlApiKey = '?api_key=c7d7585faad21b08a085bd6dde6cf0ce';
  final String _urlBase = 'https://api.themoviedb.org/3/movie';
  final String _urlUpcoming = '/upcoming';
  final String _urlLanguage = '&language=ru-RU';

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
}
