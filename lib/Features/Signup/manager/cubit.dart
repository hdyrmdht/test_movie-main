import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/Core/error/faliure.dart';
import 'package:movie/Features/Signup/manager/states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  signUp() async {
    try {
      emit(SignUpLoadingState());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      await addUsers();
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      emit(SignUpSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpErrorState(
            ServerFailure(message: 'The password provided is too weak.')));
      }
      if (e.code == 'email-already-in-use') {
        emit(SignUpErrorState(ServerFailure(
            message: 'The account already exists for that email.')));
      }
      emit(SignUpErrorState(ServerFailure(message: e.code)));
    } catch (e) {
      emit(SignUpErrorState(ServerFailure(message: e.toString())));
    }
  }

  addUsers() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.add({
      "fullName": name.text,
      "email": email.text,
      "phoneNumber": phone.text
    });
  }
}
