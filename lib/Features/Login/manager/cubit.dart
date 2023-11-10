import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/Core/error/faliure.dart';
import 'package:movie/Features/Login/manager/states.dart';

class LogInCubit extends Cubit<LogInStates>{
  LogInCubit() : super(LogInInitState());

  static LogInCubit get(context) => BlocProvider.of(context);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  logIn()async{
    try {
      emit(LogInLoadingState());
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text,
          password: password.text
      );
      emit(LogInSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LogInErrorState(ServerFailure(message:'No user found for that email.')));
      }  if (e.code == 'wrong-password') {
        emit(LogInErrorState(ServerFailure(message:'Wrong password provided for that user.')));
      }
      emit(LogInErrorState(ServerFailure(message:e.code)));
    }
  }
}
