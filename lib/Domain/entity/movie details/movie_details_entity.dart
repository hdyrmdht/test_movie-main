class MovieDetailsEntity {
  MovieDetailsEntity({
    this.adult,
    this.backdropPath,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  bool? adult;
  String? backdropPath;
  List<GenresMovieEntity>? genres;
  String? homepage;
  int? id;
  String? imdbId;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
}

class GenresMovieEntity {
  GenresMovieEntity({
    this.id,
    this.name,
  });

  int? id;
  String? name;
}
