import 'package:evently/core/routes/pages_route_name.dart';
import 'package:evently/modules/login/login_screen.dart';
import 'package:evently/modules/splash/splash_screen.dart';
import 'package:flutter/material.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PagesRouteName.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case PagesRouteName.signIn:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      default:
        return MaterialPageRoute(builder: (context) => SplashScreen());
    }
  }
}
