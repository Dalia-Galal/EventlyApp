import 'package:evently/core/app_theme/theme_manager.dart';
import 'package:evently/core/routes/app_router.dart';
import 'package:evently/core/routes/pages_route_name.dart';
import 'package:evently/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Event App',
    debugShowCheckedModeBanner: false,
    theme: ThemeManager.themeDataLight,
    initialRoute:PagesRouteName.splash,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
