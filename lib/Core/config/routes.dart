import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/Core/config/page_route_name.dart';
import 'package:movie/Features/Forgot%20Password/pages/forgot_password_view.dart';
import 'package:movie/Features/Movie%20Details/pages/movie_details_screen.dart';
import 'package:movie/Features/Movies%20List/pages/movies_list_view.dart';
import '../../Features/Home/pages/home_layout.dart';
import '../../Features/Login/pages/login_view.dart';
import '../../Features/Signup/pages/signup_view.dart';
import '../../Features/Splash/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case PageRouteName.initial:
        return MaterialPageRoute<dynamic>(
            builder: (context) => const SplashView(), settings: routeSettings);
      case PageRouteName.login:
        return MaterialPageRoute<dynamic>(
            builder: (context) => LogInView(), settings: routeSettings);
      case PageRouteName.signUp:
        return MaterialPageRoute<dynamic>(
            builder: (context) =>  SignUpView(), settings: routeSettings);
      case PageRouteName.forgot:
        return MaterialPageRoute<dynamic>(
            builder: (context) =>  const ForgotPasswordView(), settings: routeSettings);
      case PageRouteName.home:
        return MaterialPageRoute<dynamic>(
            builder: (context) => const HomeLayout(), settings: routeSettings);
      case PageRouteName.movieDetails:
        int? movieId = routeSettings.arguments as int?;
        return MaterialPageRoute<dynamic>(
            builder: (context) => MovieDetailsScreen(movieId!),
            settings: routeSettings);
      case PageRouteName.moviesList:
        int? categoryId = routeSettings.arguments as int?;
        return MaterialPageRoute<dynamic>(
            builder: (context) => MoviesListView(categoryId!),
            settings: routeSettings);
      default:
        return MaterialPageRoute<dynamic>(
            builder: (context) => const SplashView(), settings: routeSettings);
    }
  }
}
