import 'package:movie/Core/error/faliure.dart';

abstract class ForgotPasswordStates{}

class ForgotInitState extends ForgotPasswordStates{}
class ForgotLoadingState extends ForgotPasswordStates{}
class ForgotErrorState extends ForgotPasswordStates{
   Failure failure;
   ForgotErrorState(this.failure);
}
class ForgotSuccessState extends ForgotPasswordStates{}
