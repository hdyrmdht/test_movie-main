import '../../../Domain/entity/home/get_movie_entity.dart';

class GetMovieModel extends GetMovieEntity {
  GetMovieModel({
    super.page,
    super.results,
    this.totalPages,
    this.totalResults,
  });

  GetMovieModel.fromJson(dynamic json) {
    page = json['page'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(ResultsMovieModel.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  int? totalPages;
  int? totalResults;
}

class ResultsMovieModel extends ResultsMovieEntity {
  ResultsMovieModel({
    super.user,
    super.adult,
    super.backdropPath,
    super.genreIds,
    super.id,
    super.originalLanguage,
    super.originalTitle,
    super.overview,
    super.popularity,
    super.posterPath,
    super.releaseDate,
    super.title,
    super.video,
    super.voteAverage,
    super.voteCount,
  });

  ResultsMovieModel.fromJson(dynamic json) {
    user = json['user'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'] != null ? json['genre_ids'].cast<int>() : [];
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user ;
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}
