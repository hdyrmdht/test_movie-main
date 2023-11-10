class MovieCategoryEntity {
  MovieCategoryEntity({
    this.genres,
  });

  List<GenresCategoryEntity>? genres;
}

class GenresCategoryEntity {
  GenresCategoryEntity({
    this.id,
    this.name,
  });

  int? id;
  String? name;
}
