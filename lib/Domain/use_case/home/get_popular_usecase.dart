import 'package:dartz/dartz.dart';
import 'package:movie/Core/error/faliure.dart';
import 'package:movie/Domain/entity/home/get_movie_entity.dart';
import 'package:movie/Domain/repository/home/home_repository.dart';

class GetPopularUseCase{
  HomeRepository homeRepository;
  GetPopularUseCase(this.homeRepository);

  Future<Either<Failure,GetMovieEntity>>execute()=>homeRepository.getPopular();
}