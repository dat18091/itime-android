import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:itime/widgets/splash_screen_custom.dart';
import 'package:itime/widgets/tabbar_custom.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new AnimatedSplashScreen(
        splash: new Container(
          height: size.height * 3,
          width: size.width * 3,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/timelab.png"),
            ),
          ),
        ),
        nextScreen: new TabbarCustom(),
      splashTransition: SplashTransition.rotationTransition,
      backgroundColor: new HexColor("FF4E44"),
      duration: 3000,
    );
  }
}
