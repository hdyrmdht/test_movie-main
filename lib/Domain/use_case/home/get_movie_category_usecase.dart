import 'package:dartz/dartz.dart';
import 'package:movie/Core/error/faliure.dart';
import 'package:movie/Domain/repository/home/home_repository.dart';

import '../../entity/home/movie_category_entity.dart';

class GetMovieCategoryUseCase{
  HomeRepository homeRepository;
  GetMovieCategoryUseCase(this.homeRepository);

  Future<Either<Failure,MovieCategoryEntity >>execute() =>homeRepository.getMovieCategory();
}