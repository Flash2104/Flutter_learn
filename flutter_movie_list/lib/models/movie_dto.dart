class MovieListDto {
  List<MovieDto> movies;
  int currentPage;
  int totalPages;
  int totalResults;

  MovieListDto({Iterable movies, currentPage, totalPages, totalResults}) {
    this.movies = movies != null ? movies.map((e) => MovieDto.fromJson(e)).toList() : [];
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
  List genreList;

  MovieDto(this.id, this.title, this.voteAverage, this.releaseDate , this.overview, this.posterPath, this.genreList);

  MovieDto.fromJson(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.voteAverage = map['vote_average']*1.0;
    this.releaseDate = map['release_date'];
    this.overview = map['overview'];
    this.posterPath = map['poster_path'];
    this.genreList = map['genre_ids'] ?? [];
  }
}
