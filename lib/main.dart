import 'package:bot_toast/bot_toast.dart';
import 'package:evently/core/app_theme/theme_manager.dart';
import 'package:evently/core/routes/app_router.dart';
import 'package:evently/core/routes/pages_route_name.dart';
import 'package:evently/firebase_options.dart';
import 'package:evently/modules/appProvider/app_provider.dart';
import 'package:evently/services/easy_loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(create : (context) => AppProvider(),
      child: const MyApp()));
  config();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<AppProvider>(context);
    return MaterialApp(
      title: 'Event App',
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.themeDataLight,
      darkTheme: ThemeManager.themeDataDark,
      themeMode:provider.currentThemeMode ,
      initialRoute: PagesRouteName.splash,
      onGenerateRoute: AppRouter.onGenerateRoute,
      builder: EasyLoading.init(
        builder: BotToastInit(),

      ),
    );
  }
}
