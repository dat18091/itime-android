import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'apps/a1_login/a1_login.dart';
//import 'package:itime/apps/a12_notification/a12_notification.dart';
//import 'package:itime/apps/a13_shift_works/a13_shift_works.dart';
//import 'package:itime/apps/a2_register/a2_signup.dart';
//import 'package:itime/apps/a3_home/a3_check_in.dart';
//import 'package:itime/apps/a6_report/a6_report.dart';
//import 'package:itime/apps/a8_salary/a8_salary.dart';
//import 'package:itime/apps/a9_reward/a9_reward.dart';
//import 'package:itime/apps/a7_schedule/a7_schedule.dart';
//import 'package:itime/blocs/login_bloc.dart';
//import 'package:provider/provider.dart';
//
//import 'apps/a1_login/a1_login.dart';
//import 'apps/a3_home/a3_home_page.dart';
//import 'blocs/register_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
//        Provider<LoginBloc>(create: (_) => LoginBloc()),
//        Provider<RegisterBloc>(create: (_) => RegisterBloc()),
        // Provider<AnotherThing>(create: (_) => AnotherThing()),
      ],
      // create: (context) => LoginBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Open Sans',
        ),
        routes: <String, WidgetBuilder>{
//          "/home-page": (BuildContext context) => new HomePage(), //ng ban hang
//          "/log-in": (BuildContext context) => new Login(),
//          "/sign-up": (BuildContext context) => new Signup(),
//          "/check-in": (BuildContext context) => new CheckIn(),
//          "/report": (BuildContext context) => new ReportSummary(),
//          "/notification": (BuildContext context) => new NotificationManager(),
//          "/reward": (BuildContext context) => new RewardScreen(),
//          "/shift-works": (BuildContext context) => new ShiftWorkds(),
//          "/task_schedule": (BuildContext context) => new TaskSchedule(),
//          "/salary": (BuildContext context) => new SalarySummary(),
        },
      ),
    );
  }
}
