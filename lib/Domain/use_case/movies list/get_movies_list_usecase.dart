import 'package:dartz/dartz.dart';
import 'package:movie/Domain/repository/movies%20list/movies_list_repository.dart';

import '../../../Core/error/faliure.dart';
import '../../entity/home/get_movie_entity.dart';

class GetMovieListUseCase {
  MoviesListRepository moviesListRepository;

  GetMovieListUseCase(this.moviesListRepository);

  Future<Either<Failure, GetMovieEntity>> execute(int genreId) =>
      moviesListRepository.getMoviesList(genreId);
}

