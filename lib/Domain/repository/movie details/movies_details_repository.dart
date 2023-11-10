import 'package:dartz/dartz.dart';
import 'package:movie/Core/error/faliure.dart';
import 'package:movie/Domain/entity/movie%20details/movie_details_entity.dart';

import '../../entity/home/get_movie_entity.dart';

abstract class MovieDetailsRepository{
   Future<Either<Failure ,MovieDetailsEntity>> getMovieDetails(int movieId);
   Future<Either<Failure, GetMovieEntity>> getSimilarMovies(int movieId);
}