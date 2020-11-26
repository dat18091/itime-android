import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:itime/apps/a3_home/a3_home_screen.dart';
import 'package:itime/apps/a4_news_feed/a4_news_feed_screen.dart';
import 'package:itime/apps/a5_notification/a5_notification_screen.dart';
import 'package:itime/apps/a6_message/a6_message_screen.dart';
import 'package:itime/apps/a7_personal/a7_personal_screen.dart';

class TabbarCustom extends StatefulWidget {
  @override
  _TabbarCustomState createState() => _TabbarCustomState();
}

class _TabbarCustomState extends State<TabbarCustom> {
  int _selectedIndex = 0;
  final tabs = [
    new HomeScreen(),
    new NewFeeds(),
    new NotificationManager(),
    new MessageScreen(),
    new PersonalScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: new HexColor("F6F6F6"),
      body: tabs[_selectedIndex],
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.featured_play_list),
            label: 'Bản tin',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Thông báo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Cá nhân',
          ),
        ],
        selectedItemColor: Colors.amber[800],
        onTap: (value) {
          _selectedIndex = value;
          setState(() {});
        },
      ),
    );
  }
}
