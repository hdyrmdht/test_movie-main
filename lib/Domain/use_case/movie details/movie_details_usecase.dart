import 'package:dartz/dartz.dart';
import 'package:movie/Core/error/faliure.dart';
import 'package:movie/Domain/repository/movie%20details/movies_details_repository.dart';

import '../../entity/movie details/movie_details_entity.dart';

class MovieDetailsUseCase{
  MovieDetailsRepository movieDetailsRepository;
  MovieDetailsUseCase(this.movieDetailsRepository);

  Future<Either<Failure, MovieDetailsEntity>>execute(int movieId) =>movieDetailsRepository.getMovieDetails(movieId);
}