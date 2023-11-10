import 'package:dartz/dartz.dart';
import 'package:movie/Core/error/faliure.dart';

import '../../entity/home/get_movie_entity.dart';

abstract class MoviesListRepository {
  Future<Either<Failure, GetMovieEntity>> getMoviesList(int genreId);
}
