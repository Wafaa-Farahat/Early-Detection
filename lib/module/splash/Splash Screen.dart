import 'dart:ui';

import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:page_transition/page_transition.dart';

import '../on boarding/On Boarding.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image(
        fit: BoxFit.cover,
        image: AssetImage("images/home_logo.png"),
      ),
      nextScreen: OnBoardingScreen(),
      duration: 2000,
      splashTransition: SplashTransition.scaleTransition,
      backgroundColor: Color.fromRGBO(0, 129, 201, 100),
      pageTransitionType: PageTransitionType.rightToLeftWithFade,
      splashIconSize: 200,
    );
  }
}
