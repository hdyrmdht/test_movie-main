import 'package:dartz/dartz.dart';
import 'package:movie/Core/error/faliure.dart';
import 'package:movie/Domain/entity/home/get_movie_entity.dart';

import '../../entity/home/get_new_release_entity.dart';
import '../../entity/home/movie_category_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, GetMovieEntity>> getPopular();

  Future<Either<Failure, GetMovieEntity>> getNewRelease();

  Future<Either<Failure, GetMovieEntity>> getTopRated();

  Future<Either<Failure, GetMovieEntity>> searchMovie(String query);

  Future<Either<Failure, MovieCategoryEntity>> getMovieCategory();
}
