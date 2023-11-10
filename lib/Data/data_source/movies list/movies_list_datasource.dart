import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie/Data/model/home/get_movie_model.dart';

import '../../../Core/constants/costants.dart';
import '../../../Core/error/faliure.dart';

abstract class MoviesListDataSource {
  Future<Either<Failure, GetMovieModel>> getMoviesList(int genreId);
}

class RemoteMovieListDto implements MoviesListDataSource {
  final Dio dio = Dio();

  @override
  Future<Either<Failure, GetMovieModel>> getMoviesList(int genreId) async {
    try {
      var response = await dio.get(
          "${Constants.baseUrl}/discover/movie",
          queryParameters: {
            "api_key": Constants.apiKey,
            "with_genres": genreId,
          }
      );
      GetMovieModel model = GetMovieModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
