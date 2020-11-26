import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:itime/apps/a1_login/a1_login_screen.dart';
import 'package:itime/widgets/splash_screen_custom.dart';

/**
 * @author datnq
 * @Date: 23/11/2020
 *
 * Modification Logs
 * DATE   		AUTHOR 		DESCRIPTION
 * ------------------------------------
 * 23/11/2020	DatNQ		  loading screen
 */
class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new SafeArea(
      child: new Container(
        width: size.width,
        height: size.height,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/onb2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: new AnimatedSplashScreen(
//            splash: new Container(
//              height: size.height * 3,
//              width: size.width * 3,
//              decoration: new BoxDecoration(
//                image: new DecorationImage(
//                  image: new AssetImage("assets/images/timelab.png"),
//                ),
//              ),
//            ),
            nextScreen: new LoginScreen(),
//          splashTransition: SplashTransition.rotationTransition,
          backgroundColor: Colors.transparent,
          duration: 3000,
        ),
      ),
    );
  }
}
