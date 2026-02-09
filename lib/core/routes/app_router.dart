import 'package:evently/core/routes/pages_route_name.dart';
import 'package:evently/modules/add_event/add_event_.dart';
import 'package:evently/modules/edit_event/edit_event.dart';
import 'package:evently/modules/event_details/event_details.dart';
import 'package:evently/modules/forget_password/forget_password.dart';
import 'package:evently/modules/layout/layout.dart';
import 'package:evently/modules/login/login_screen.dart';
import 'package:evently/modules/sign_up/sign_up.dart';
import 'package:evently/modules/splash/splash_screen.dart';
import 'package:flutter/material.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PagesRouteName.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case PagesRouteName.signIn:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case PagesRouteName.signUp:
        return MaterialPageRoute(builder: (context) => SignUp(),settings: settings);
      case PagesRouteName.forgetPassword:
        return MaterialPageRoute(builder: (context) => ForgetPassword());
      case PagesRouteName.layout:
        return MaterialPageRoute(builder: (context) => Layout(),settings: settings);
      case PagesRouteName.addEvent:
        return MaterialPageRoute(builder: (context)=>AddEvent());
      case PagesRouteName.eventDetails:
        return MaterialPageRoute(builder: (context) =>EventDetails(), settings: settings,);
      case PagesRouteName.editEvent:
        return MaterialPageRoute(builder: (context) =>EditEvent(), settings: settings,);
      default:
        return MaterialPageRoute(builder: (context) => SplashScreen());
    }
  }
}
