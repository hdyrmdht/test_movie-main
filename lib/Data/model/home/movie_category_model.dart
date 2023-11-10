import 'package:movie/Domain/entity/home/movie_category_entity.dart';

class MovieCategoryModel extends MovieCategoryEntity {
  MovieCategoryModel({
    super.genres,
  });

  MovieCategoryModel.fromJson(dynamic json) {
    if (json['genres'] != null) {
      genres = [];
      json['genres'].forEach((v) {
        genres?.add(Genres.fromJson(v));
      });
    }
  }
}

class Genres extends GenresCategoryEntity {
  Genres({
    super.id,
    super.name,
  });

  Genres.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
}
