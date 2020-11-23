import 'package:flutter/material.dart';
import 'package:itime/apps/a16_splash/a16_loading_screen.dart';
//import 'package:itime/apps/a16_splash/a16_splash_screen.dart';
import 'package:itime/apps/a1_login/a1_login_screen.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: new PageTransitionsTheme(
          builders: {
            TargetPlatform.android: new CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: new CupertinoPageTransitionsBuilder()
          },
        ),
        primarySwatch: Colors.blue,
        fontFamily: 'Open Sans',
      ),
      home: new LoadingScreen(),
    );
  }
}
