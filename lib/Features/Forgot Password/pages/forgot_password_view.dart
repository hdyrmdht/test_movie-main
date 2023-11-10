import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/Core/extentions/extentions.dart';
import 'package:movie/Features/Forgot%20Password/manager/states.dart';

import '../../../Core/config/page_route_name.dart';
import '../../../Core/services/toast.dart';
import '../../../Core/widgets/custom_textfield.dart';
import '../../../main.dart';
import '../manager/cubit.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordStates>(
          listener: (context, state) {
        if (state is ForgotLoadingState) {
          EasyLoading.show();
        }
        if (state is ForgotErrorState) {
          EasyLoading.dismiss();
          errorToast(context,
              title: "error", description: state.failure.message);
        }
        if (state is ForgotSuccessState) {
          EasyLoading.dismiss();
          navigatorKey.currentState?.pushNamed(PageRouteName.login);
          successToast(context,
              title: "Reset Password",
              description: "Check your Email to reset Password");
        }
      }, builder: (context, state) {
        var theme = Theme.of(context);
        var cubit = ForgotPasswordCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Forgot Password", style: theme.textTheme.displayLarge)
                    .setOnlyPadding(context, top: 0.02),
                Image.asset(
                  "assets/images/icons/forgot.png",
                  scale: 0.5,
                ).setPadding(context, horizontal: 0.15, vertical: 0.03),
                Text(
                  textAlign: TextAlign.center,
                  "Enter your registered email below to receive \n password reset instruction",
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.normal),
                ).setOnlyPadding(context, bottom: 0.12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email Address",
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                CustomTextField(
                  onValidate: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "you must enter your e-mail";
                    } else {
                      return null;
                    }
                  },
                  hint: "enter your e-mail",
                   controller:cubit.email,
                ).setOnlyPadding(context, top: 0.01, bottom: 0.01),
                SizedBox(
                  height: 50.h,
                ),
                TextButton(
                  onPressed: () {
                    cubit.resetPassword();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(theme.primaryColor),
                    padding: const MaterialStatePropertyAll(EdgeInsets.all(18)),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                  child: Text("Send Reset Password Link",
                      style: theme.textTheme.bodyLarge),
                ),
                TextButton(
                    onPressed: () {
                      navigatorKey.currentState
                          ?.pushReplacementNamed(PageRouteName.login);
                    },
                    child: Text(
                      "Sign in to your Account ?",
                      style: theme.textTheme.bodyMedium,
                    )).setOnlyPadding(context, top: 0.01)
              ],
            )
                .setOnlyPadding(context, top: 0.1)
                .setPadding(context, horizontal: 0.04),
          ),
        );
      }),
    );
  }
}
