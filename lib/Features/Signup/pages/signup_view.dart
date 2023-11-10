import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movie/Core/extentions/extentions.dart';
import 'package:movie/Features/Signup/manager/cubit.dart';
import 'package:movie/Features/Signup/manager/states.dart';

import '../../../Core/config/page_route_name.dart';
import '../../../Core/services/toast.dart';
import '../../../Core/widgets/custom_textfield.dart';
import '../../../main.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
          listener: (context, state) {
            if (state is SignUpLoadingState) {
              EasyLoading.show();
            }
            if (state is SignUpErrorState) {
              EasyLoading.dismiss();
              errorToast(context, title: "error", description: state.fail.message);
            }
            if (state is SignUpSuccessState) {
              EasyLoading.dismiss();
              navigatorKey.currentState?.pushNamed(PageRouteName.login);
              successToast(context,
                  title: "signup", description: "successfully, Check your email to verify Account");
            }
          },
          builder: (context, state) {
            var mediaQuery = MediaQuery.of(context).size;
            var theme = Theme.of(context);
            var cubit = SignUpCubit.get(context);
            return Form(
              key: formKey,
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        "assets/images/icons/movies.png",
                        scale: 0.8,
                      ).setPadding(context, horizontal: 0.24, vertical: 0.05),
                      Text(
                        "Full Name",
                        style: theme.textTheme.bodyMedium,
                      ),
                      CustomTextField(
                        onValidate: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "you must enter your full name";
                          } else {
                            return null;
                          }
                        },
                        hint: "enter your user name",
                          controller: cubit.name,
                      ).setOnlyPadding(context, top: 0.01, bottom: 0.03),
                      Text(
                        "Email Address",
                        style: theme.textTheme.bodyMedium,
                      ),
                      CustomTextField(
                        onValidate: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "you must enter your e-mail";
                          } else {
                            return null;
                          }
                        },
                        hint: "enter your user email",
                         controller: cubit.email,
                      ).setOnlyPadding(context, top: 0.01, bottom: 0.03),
                      Text(
                        "Password",
                        style: theme.textTheme.bodyMedium,
                      ),
                      CustomTextField(
                        onValidate: (String? value) {
                          if (value == null || value.trim().isEmpty) {
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
                      ).setOnlyPadding(context, top: 0.01, bottom: 0.03),
                      Text(
                        "Phone Number",
                        style: theme.textTheme.bodyMedium,
                      ),
                      CustomTextField(
                        onValidate: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "you must enter your number";
                          } else {
                            return null;
                          }
                        },
                        hint: "enter your user number",
                         controller: cubit.phone,
                      ).setOnlyPadding(context, top: 0.01, bottom: 0.07),
                      TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.signUp();
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
                        child: Text("Signup", style: theme.textTheme.bodyLarge),
                      ),
                      TextButton(
                          onPressed: () {
                            navigatorKey.currentState
                                ?.pushReplacementNamed(PageRouteName.login);
                          },
                          child: Text(
                            "Already have an account ?",
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
