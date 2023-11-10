import 'package:dartz/dartz.dart';
import 'package:movie/Core/error/faliure.dart';
import 'package:movie/Domain/repository/movie%20details/movies_details_repository.dart';

import '../../entity/home/get_movie_entity.dart';

class SimilarMoviesUseCase{
  MovieDetailsRepository movieDetailsRepository;
  SimilarMoviesUseCase(this.movieDetailsRepository);
  Future<Either<Failure, GetMovieEntity>>execute(int movieId) =>movieDetailsRepository.getSimilarMovies(movieId);
}