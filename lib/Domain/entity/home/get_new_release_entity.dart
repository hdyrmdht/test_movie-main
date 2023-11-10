
class GetNewReleaseEntity {
  GetNewReleaseEntity({
      this.dates,
      this.results,});


  DatesNewReleaseEntity? dates;
  List<ResultsNewReleaseEntity>? results;



}

class ResultsNewReleaseEntity {
  ResultsNewReleaseEntity({
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
      this.voteCount,});


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
  double? voteAverage;
  int? voteCount;



}


class DatesNewReleaseEntity {
  DatesNewReleaseEntity({
      this.maximum,
      this.minimum,});

  DatesNewReleaseEntity.fromJson(dynamic json) {
    maximum = json['maximum'];
    minimum = json['minimum'];
  }
  String? maximum;
  String? minimum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['maximum'] = maximum;
    map['minimum'] = minimum;
    return map;
  }

}