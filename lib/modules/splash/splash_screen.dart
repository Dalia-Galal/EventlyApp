import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
