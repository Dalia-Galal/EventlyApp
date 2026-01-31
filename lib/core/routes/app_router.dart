import 'package:evently/core/routes/pages_route_name.dart';
import 'package:evently/modules/splash/splash_screen.dart';
import 'package:flutter/material.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PagesRouteName.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      default:
        return MaterialPageRoute(builder: (context) => SplashScreen());
    }
  }
}
