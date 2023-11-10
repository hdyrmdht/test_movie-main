import 'package:dartz/dartz.dart';
import 'package:movie/Core/error/faliure.dart';
import 'package:movie/Data/data_source/movie%20details/movie_details_datasource.dart';
import 'package:movie/Domain/entity/home/get_movie_entity.dart';
import 'package:movie/Domain/entity/movie%20details/movie_details_entity.dart';
import 'package:movie/Domain/repository/movie%20details/movies_details_repository.dart';

class MovieDetailsRepositoryImp implements MovieDetailsRepository{

  MovieDetailsDatasource movieDetailsDatasource;
  MovieDetailsRepositoryImp (this.movieDetailsDatasource);

  @override
  Future<Either<Failure, MovieDetailsEntity>> getMovieDetails(int movieId) {
   return movieDetailsDatasource.getMovieDetails(movieId);
  }

  @override
  Future<Either<Failure, GetMovieEntity>> getSimilarMovies(int movieId) {
    return movieDetailsDatasource.getSimilarMovies(movieId);
  }

}