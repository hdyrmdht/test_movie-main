import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/Features/Forgot%20Password/manager/states.dart';

import '../../../Core/error/faliure.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordStates> {
  ForgotPasswordCubit() : super(ForgotInitState());

  static ForgotPasswordCubit get(context) => BlocProvider.of(context);
  TextEditingController email = TextEditingController();

  resetPassword() async {
    try {
      emit(ForgotLoadingState());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
      emit(ForgotSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(ForgotErrorState(ServerFailure(message: e.toString())));
    }
  }
}
