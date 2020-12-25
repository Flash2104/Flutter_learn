import 'dart:io';
import 'package:http/http.dart' as http;

class MovieHttpService {
  final String _urlApiKey = 'api_key=c7d7585faad21b08a085bd6dde6cf0ce';
  final String _urlBase = 'https://api.themoviedb.org/3/movie';
  final String _urlUpcoming = '/upcoming';
  final String _urlLanguage = '&language=en-US';

  Future<String> getUpcoming() async {
    final String upcoming = _urlBase + _urlUpcoming + _urlApiKey + _urlLanguage;
    http.Response result = await http.get(upcoming);
    if (result.statusCode == HttpStatus.ok) {
      String responseBody = result.body;
      return responseBody;
    } else {
      return null;
    }
  }
}
