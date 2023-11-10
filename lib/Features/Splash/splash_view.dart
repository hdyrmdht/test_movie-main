import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Core/config/page_route_name.dart';
import '../../main.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      navigatorKey.currentState?.pushReplacementNamed(
        FirebaseAuth.instance.currentUser == null
            ? PageRouteName.login
            : FirebaseAuth.instance.currentUser!.emailVerified
                ? PageRouteName.home
                : PageRouteName.login,
      );
    });
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/logos/splash.png"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
