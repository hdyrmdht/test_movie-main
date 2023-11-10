import '../../../Core/error/faliure.dart';

abstract class SignUpStates {}

class SignUpInitState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates {}

class SignUpErrorState extends SignUpStates {
  Failure fail;

  SignUpErrorState(this.fail);
}

class SignUpSuccessState extends SignUpStates {}
