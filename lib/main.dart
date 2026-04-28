import 'package:bot_toast/bot_toast.dart';
import 'package:evently/core/app_theme/theme_manager.dart';
import 'package:evently/core/providers/appProvider/app_provider.dart';
import 'package:evently/core/providers/auth_provider/auth_provider.dart';
import 'package:evently/core/routes/app_router.dart';
import 'package:evently/core/routes/pages_route_name.dart';
import 'package:evently/firebase_options.dart';
import 'package:evently/services/easy_loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/l10n/app_localizations.dart';
//keytool -list -v -keystore "C:\Users\Dalia\.android\debug.keystore"-alias androiddebugkey -storepass android -keypass android
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider(prefs)),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
      ],

      child: const MyApp(),
    ),
  );
  config();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();

    return Consumer<AuthenticationProvider>(
      builder: (context,auth,_) {
        return MaterialApp(
          title: 'Event App',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(provider.currentLanguage),
          debugShowCheckedModeBanner: false,
          theme: ThemeManager.themeDataLight,
          darkTheme: ThemeManager.themeDataDark,
          themeMode: provider.currentThemeMode,
          initialRoute: PagesRouteName.splash,
          onGenerateRoute: AppRouter.onGenerateRoute,
          builder: EasyLoading.init(builder: BotToastInit()),
        );
      }
    );
  }
}
