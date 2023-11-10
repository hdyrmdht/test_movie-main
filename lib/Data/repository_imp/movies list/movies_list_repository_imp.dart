import 'package:dartz/dartz.dart';
import 'package:movie/Core/error/faliure.dart';
import 'package:movie/Data/data_source/movies%20list/movies_list_datasource.dart';
import 'package:movie/Domain/entity/home/get_movie_entity.dart';
import 'package:movie/Domain/repository/movies%20list/movies_list_repository.dart';

class MoviesListRepositoryImp implements MoviesListRepository{

  MoviesListDataSource moviesListDataSource;
  MoviesListRepositoryImp(this.moviesListDataSource);
  @override
  Future<Either<Failure, GetMovieEntity>> getMoviesList(int genreId) {
    return moviesListDataSource.getMoviesList(genreId);
  }

}