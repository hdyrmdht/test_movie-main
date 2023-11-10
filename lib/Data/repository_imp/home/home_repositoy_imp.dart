import 'package:dartz/dartz.dart';
import 'package:movie/Core/error/faliure.dart';
import 'package:movie/Data/model/home/get_new_release_model.dart';
import 'package:movie/Domain/entity/home/get_new_release_entity.dart';
import 'package:movie/Domain/entity/home/get_movie_entity.dart';
import 'package:movie/Domain/entity/home/movie_category_entity.dart';
import 'package:movie/Domain/repository/home/home_repository.dart';

import '../../data_source/home/home_datasource.dart';

class HomeRepositoryImp implements HomeRepository {
  HomeDataSource homeDataSource;

  HomeRepositoryImp(this.homeDataSource);

  @override
  Future<Either<Failure, GetMovieEntity>> getPopular() {
    return homeDataSource.getPopular();
  }

  @override
  Future<Either<Failure, GetMovieEntity>> getNewRelease() {
    return homeDataSource.getNewRelease();
  }

  @override
  Future<Either<Failure, GetMovieEntity>> getTopRated() {
    return homeDataSource.getTopRated();
  }

  @override
  Future<Either<Failure, GetMovieEntity>> searchMovie(String query) {
    return homeDataSource.searchMovie(query);
  }

  @override
  Future<Either<Failure, MovieCategoryEntity>> getMovieCategory() {
    return homeDataSource.getMovieCategory();
  }
}
