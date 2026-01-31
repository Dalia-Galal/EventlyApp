import 'package:evently/core/routes/app_router.dart';
import 'package:evently/core/routes/pages_route_name.dart';
import 'package:evently/modules/login/login_screen.dart';
import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context, PagesRouteName.signIn);});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Padding(
          padding: const EdgeInsets.only(bottom: 25.0,top: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Spacer(),
              Image.asset(Assets.images.eventelyLight.path,width: 309,height: 58,),
              Spacer(),
              Image.asset(Assets.images.routeLogoLight.path,width: 217,height: 57,)
            ],
          ),
        )

      ),
    );
  }
}
