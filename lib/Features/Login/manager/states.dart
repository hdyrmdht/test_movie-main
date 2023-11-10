import '../../../Core/error/faliure.dart';

abstract class LogInStates {}

class LogInInitState extends LogInStates {}

class LogInLoadingState extends LogInStates {}

class LogInErrorState extends LogInStates {
  Failure fail;

  LogInErrorState(this.fail);
}

class LogInSuccessState extends LogInStates {}
