import 'package:evently/core/providers/auth_provider/auth_provider.dart';
import 'package:evently/core/routes/app_router.dart';
import 'package:evently/core/routes/pages_route_name.dart';
import 'package:evently/modules/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../gen/assets.gen.dart';
import 'package:evently/core/providers/appProvider/app_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () async {
      final auth = context.read<AuthenticationProvider>();
      while (!auth.isInitialized) {
        await Future.delayed(Duration(milliseconds: 100));
      }
      if (!mounted) return;
      if (auth.isLoggedIn) {
        Navigator.pushReplacementNamed(
          context,
          PagesRouteName.layout,
          arguments: auth.user,
        );
      } else {
        Navigator.pushReplacementNamed(context, PagesRouteName.signIn);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    bool isDark = provider.currentThemeMode == ThemeMode.dark;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(bottom: 25.0, top: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Spacer(),
              Image.asset(
                isDark
                    ? Assets.images.eventelyDark.path
                    : Assets.images.eventelyLight.path,
                width: 309,
                height: 58,
              ),
              Spacer(),
              Image.asset(
                isDark
                    ? Assets.images.routeLogoDark.path
                    : Assets.images.routeLogoLight.path,
                width: 217,
                height: 57,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
