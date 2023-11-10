import 'package:dartz/dartz.dart';
import 'package:movie/Core/error/faliure.dart';
import 'package:movie/Domain/repository/home/home_repository.dart';

import '../../entity/home/get_movie_entity.dart';
import '../../entity/home/get_new_release_entity.dart';

class GetNewReleaseUseCase{
  HomeRepository homeRepository;
  GetNewReleaseUseCase(this.homeRepository);
  Future<Either<Failure,GetMovieEntity>>execute() => homeRepository.getNewRelease() ;
}