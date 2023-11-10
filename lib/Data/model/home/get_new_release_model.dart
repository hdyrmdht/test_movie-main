
import 'package:movie/Domain/entity/home/get_new_release_entity.dart';

class GetNewReleaseModel extends GetNewReleaseEntity{
  GetNewReleaseModel({
      super.dates,
      this.page,
      super.results,
      this.totalPages,
      this.totalResults,});

  GetNewReleaseModel.fromJson(dynamic json) {
    dates = json['dates'] != null ? Dates.fromJson(json['dates']) : null;
    page = json['page'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(ResultsNewRelease.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  int? page;

  int? totalPages;
  int? totalResults;


}

class ResultsNewRelease extends ResultsNewReleaseEntity {
  ResultsNewRelease({
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
    super.voteCount,});

  ResultsNewRelease.fromJson(dynamic json) {
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



}


class Dates extends DatesNewReleaseEntity {
  Dates({
      super.maximum,
    super.minimum,});

  Dates.fromJson(dynamic json) {
    maximum = json['maximum'];
    minimum = json['minimum'];
  }


}