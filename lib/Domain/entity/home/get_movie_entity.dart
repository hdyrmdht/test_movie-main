class GetMovieEntity {
  GetMovieEntity({
    this.page,
    this.results,
  });

  int? page;
  List<ResultsMovieEntity>? results;

}

class ResultsMovieEntity {
  ResultsMovieEntity({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.user,
  });

  String? user;
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  num? voteAverage;
  int? voteCount;
}
