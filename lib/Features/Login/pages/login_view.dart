import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movie/Core/extentions/extentions.dart';
import 'package:movie/Features/Login/manager/cubit.dart';
import 'package:movie/Features/Login/manager/states.dart';

import '../../../Core/config/page_route_name.dart';
import '../../../Core/services/toast.dart';
import '../../../Core/widgets/custom_textfield.dart';
import '../../../main.dart';

class LogInView extends StatelessWidget {
  LogInView({super.key});

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogInCubit(),
      child: BlocConsumer<LogInCubit, LogInStates>(
          listener: (context, state) {
            if (state is LogInLoadingState) {
              EasyLoading.show();
            }
            if (state is LogInErrorState) {
              EasyLoading.dismiss();
              errorToast(
                  context, title: "error", description: state.fail.message);
            }
            if (state is LogInSuccessState) {
              EasyLoading.dismiss();
              FirebaseAuth.instance.currentUser!.emailVerified ? {
                navigatorKey.currentState?.pushNamed(PageRouteName.home),
                successToast(
                    context, title: "Login", description: "Login successfully")
              } :{
                errorToast(context, title: "error",
                    description: "check your email to verify Account")
              };
            }
          },
          builder: (context, state) {
            var mediaQuery = MediaQuery
                .of(context)
                .size;
            var theme = Theme.of(context);
            var cubit = LogInCubit.get(context);
            return Form(
              key: formKey,
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        "assets/images/icons/movies.png",
                        scale: 0.8,
                      ).setPadding(context, horizontal: 0.24, vertical: 0.08),
                      Row(
                        children: [
                          Text("Welcome Back To MOVIES",
                              style: theme.textTheme.headlineMedium),
                        ],
                      ).setOnlyPadding(context, top: 0.01),
                      Text(
                        "Please sign in with your mail",
                        style: theme.textTheme.bodySmall,
                      ).setOnlyPadding(context, bottom: 0.03, top: 0.002),
                      Text(
                        "Email Address",
                        style: theme.textTheme.bodyMedium,
                      ),
                      CustomTextField(
                        onValidate: (String? value) {
                          if (value == null || value
                              .trim()
                              .isEmpty) {
                            return "you must enter your e-mail";
                          } else {
                            return null;
                          }
                        },
                        hint: "enter your user name",
                        controller: cubit.email,
                      ).setOnlyPadding(context, top: 0.01, bottom: 0.03),
                      Text(
                        "Password",
                        style: theme.textTheme.bodyMedium,
                      ),
                      CustomTextField(
                        onValidate: (String? value) {
                          if (value == null || value
                              .trim()
                              .isEmpty) {
                            return "you must enter your password";
                          } else if (value.length < 6) {
                            return "description cant be less than 6 characters";
                          } else {
                            return null;
                          }
                        },
                        hint: "enter your password",
                        controller: cubit.password,
                        isPassword: true,
                      ).setOnlyPadding(context, top: 0.01),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                               Navigator.pushNamed(context, PageRouteName.forgot);
                            },
                            child: Text(
                              "Forgot password",
                              style: theme.textTheme.bodySmall,
                            )).setOnlyPadding(context, bottom: 0.05),
                      ),
                      TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.logIn();
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStatePropertyAll(theme.primaryColor),
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.all(14)),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        child: Text("Login", style: theme.textTheme.bodyLarge),
                      ),
                      TextButton(
                          onPressed: () {
                            navigatorKey.currentState
                                ?.pushReplacementNamed(PageRouteName.signUp);
                          },
                          child: Text(
                            "Don’t have an account? Create Account",
                            style: theme.textTheme.bodySmall,
                          )).setOnlyPadding(context, top: 0.01)
                    ],
                  )
                      .setOnlyPadding(context, top: 0.02)
                      .setPadding(context, horizontal: 0.04),
                ),
              ),
            );
          }),
    );
  }
}
