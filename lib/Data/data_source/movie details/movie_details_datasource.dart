import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie/Core/error/faliure.dart';
import 'package:movie/Data/model/home/get_movie_model.dart';
import 'package:movie/Data/model/movie%20details/movie_details_model.dart';

import '../../../Core/constants/costants.dart';

abstract class MovieDetailsDatasource {
  Future<Either<Failure, MovieDetailsModel>> getMovieDetails(int movieId);
  Future<Either<Failure, GetMovieModel>> getSimilarMovies(int movieId);
}

class RemoteMovieDetailsDto implements MovieDetailsDatasource {
  final Dio dio = Dio();

  @override
  Future<Either<Failure, MovieDetailsModel>> getMovieDetails(int movieId) async{
    try {
      var response = await dio.get(
          "${Constants.baseUrl}/movie/$movieId",
          queryParameters: {
            "api_key" : Constants.apiKey
          }
      );
      MovieDetailsModel model = MovieDetailsModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetMovieModel>> getSimilarMovies(int movieId)async {
    try {
      var response = await dio.get(
          "${Constants.baseUrl}/movie/$movieId/similar",
          queryParameters: {
            "api_key" : Constants.apiKey
          }
      );
      GetMovieModel model = GetMovieModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
