import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_list/models/movie_dto.dart';
import 'package:flutter_movie_list/services/movie_http.service.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieDto _movieDto;
  final MovieHttpService _httpService = MovieHttpService();

  MovieDetailPage(this._movieDto);

  @override
  Widget build(BuildContext context) {
    CachedNetworkImage image = _httpService.getOriginalImage(_movieDto.posterPath);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text(_movieDto.title), leading: image),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: height/ 1.5,
                child: image,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(_movieDto.overview),
              )
            ],
          ),
        ),
      ),
    );
  }
}
