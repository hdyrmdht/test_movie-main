import '../../../Core/error/faliure.dart';

abstract class MoviesListStates{}

class MoviesListInitState extends MoviesListStates {}

class MoviesListLoadingState extends MoviesListStates {}

class GetMoviesListLoadingState extends MoviesListStates {}
class GetMoviesListErrorState extends MoviesListStates {
  Failure fail;
  GetMoviesListErrorState(this.fail);
}
class GetMoviesListSuccessState extends MoviesListStates {}
class AddWatchListLoadingState extends MoviesListStates {}
class AddWatchListErrorState extends MoviesListStates {
  Failure fail;
  AddWatchListErrorState(this.fail);
}
class AddWatchListSuccessState extends MoviesListStates {}

