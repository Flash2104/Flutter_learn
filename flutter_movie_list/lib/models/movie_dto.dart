class MovieListDto {
  List<MovieDto> movies;
  int currentPage;
  int totalPages;
  int totalResults;

  MovieListDto({movies, currentPage, totalPages, totalResults}) {
    this.movies = movies ?? [];
    this.currentPage = currentPage ?? 0;
    this.totalPages = totalPages ?? 0;
    this.totalResults = totalResults ?? 0;
  }
}

class MovieDto {
  int id;
  String title;
  double voteAverage;
  String releaseDate;
  String overview;
  String posterPath;

  MovieDto(this.id, this.title, this.voteAverage, this.releaseDate , this.overview, this.posterPath);

  MovieDto.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.title = parsedJson['title'];
    this.voteAverage = parsedJson['vote_average']*1.0;
    this.releaseDate = parsedJson['release_date'];
    this.overview = parsedJson['overview'];
    this.posterPath = parsedJson['poster_path'];
  }
}