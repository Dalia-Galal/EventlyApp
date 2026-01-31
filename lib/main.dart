import 'package:evently/core/routes/app_router.dart';
import 'package:evently/core/routes/pages_route_name.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Event App',
    debugShowCheckedModeBanner: false,
    initialRoute:PagesRouteName.splash,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
