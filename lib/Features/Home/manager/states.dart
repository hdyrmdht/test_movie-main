import 'package:movie/Core/error/faliure.dart';

abstract class HomeStates{}

class HomeInitState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class ChangeCurrentIndexState extends HomeStates {}

class GetPopularLoadingState extends HomeStates {}
class GetPopularErrorState extends HomeStates {
  Failure fail;
  GetPopularErrorState(this.fail);
}
class GetPopularSuccessState extends HomeStates {}

class GetNewReleaseLoadingState extends HomeStates {}
class GetNewReleaseErrorState extends HomeStates {
  Failure fail;
  GetNewReleaseErrorState(this.fail);
}
class GetNewReleaseSuccessState extends HomeStates {}
class GetTopRatedLoadingState extends HomeStates {}
class GetTopRatedErrorState extends HomeStates {
  Failure fail;
  GetTopRatedErrorState(this.fail);
}
class GetTopRatedSuccessState extends HomeStates {}
class SearchMovieLoadingState extends HomeStates {}
class SearchMovieErrorState extends HomeStates {
  Failure fail;
  SearchMovieErrorState(this.fail);
}
class SearchMovieSuccessState extends HomeStates {}

class GetMovieCategoryLoadingState extends HomeStates {}
class GetMovieCategoryErrorState extends HomeStates {
  Failure fail;
  GetMovieCategoryErrorState(this.fail);
}
class GetMovieCategorySuccessState extends HomeStates {}


class AddWatchListLoadingState extends HomeStates {}
class AddWatchListErrorState extends HomeStates {
  Failure fail;
  AddWatchListErrorState(this.fail);
}
class AddWatchListSuccessState extends HomeStates {}

class GetWatchListLoadingState extends HomeStates {}
class GetWatchListErrorState extends HomeStates {
  Failure fail;
  GetWatchListErrorState(this.fail);
}
class GetWatchListSuccessState extends HomeStates {}
class DeleteWatchListLoadingState extends HomeStates {}
class DeleteWatchListErrorState extends HomeStates {
  Failure fail;
  DeleteWatchListErrorState(this.fail);
}
class DeleteWatchListSuccessState extends HomeStates {}
class LogOutLoadingState extends HomeStates {}
class LogOutErrorState extends HomeStates {
  Failure fail;
  LogOutErrorState(this.fail);
}
class LogOutSuccessState extends HomeStates {}
