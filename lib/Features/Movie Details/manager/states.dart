import '../../../Core/error/faliure.dart';

abstract class MovieDetailsStates{}

class MovieDetailsInitState extends MovieDetailsStates {}

class MovieDetailsLoadingState extends MovieDetailsStates {}

class GetMovieDetailsLoadingState extends MovieDetailsStates {}
class GetMovieDetailsErrorState extends MovieDetailsStates {
  Failure fail;
  GetMovieDetailsErrorState(this.fail);
}
class GetMovieDetailsSuccessState extends MovieDetailsStates {}

class GetSimilarMoviesLoadingState extends MovieDetailsStates {}
class GetSimilarMoviesErrorState extends MovieDetailsStates {
  Failure fail;
  GetSimilarMoviesErrorState(this.fail);
}
class GetSimilarMoviesSuccessState extends MovieDetailsStates {}
class AddWatchListLoadingState extends MovieDetailsStates {}
class AddWatchListErrorState extends MovieDetailsStates {
  Failure fail;
  AddWatchListErrorState(this.fail);
}
class AddWatchListSuccessState extends MovieDetailsStates {}

