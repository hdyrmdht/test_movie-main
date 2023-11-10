import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie/Core/error/faliure.dart';
import 'package:movie/Data/model/home/get_movie_model.dart';
import 'package:movie/Data/model/home/movie_category_model.dart';

import '../../../Core/constants/costants.dart';
import '../../model/home/get_new_release_model.dart';

abstract class HomeDataSource {
  Future<Either<Failure, GetMovieModel>> getPopular();

  Future<Either<Failure, GetMovieModel>> getTopRated();

  Future<Either<Failure, GetMovieModel>> getNewRelease();

  Future<Either<Failure, GetMovieModel>> searchMovie(String query);

  Future<Either<Failure, MovieCategoryModel>> getMovieCategory();
}

class RemoteHomeDto implements HomeDataSource {
  final Dio dio = Dio();

  @override
  Future<Either<Failure, GetMovieModel>> getPopular() async {
    try {
      var response = await dio.get("${Constants.baseUrl}/movie/popular",
          queryParameters: {"api_key": Constants.apiKey});
      GetMovieModel model = GetMovieModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetMovieModel>> getNewRelease() async {
    try {
      var response = await dio.get("${Constants.baseUrl}/movie/upcoming",
          queryParameters: {"api_key": Constants.apiKey});
      GetMovieModel model = GetMovieModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetMovieModel>> getTopRated() async {
    try {
      var response = await dio.get("${Constants.baseUrl}/movie/top_rated",
          queryParameters: {"api_key": Constants.apiKey});
      GetMovieModel model = GetMovieModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetMovieModel>> searchMovie(String query) async {
    try {
      var response = await dio.get(
        "${Constants.baseUrl}/search/movie",
        queryParameters: {
          "api_key": Constants.apiKey,
          "query": query,
        },
      );
      GetMovieModel model = GetMovieModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MovieCategoryModel>> getMovieCategory() async {
    try {
      var response = await dio.get(
        "${Constants.baseUrl}/genre/movie/list",
        queryParameters: {"api_key": Constants.apiKey},
      );
      MovieCategoryModel model = MovieCategoryModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return left(
        ServerFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
