import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:itime/commons/constants.dart';
import 'package:itime/utils/network_util.dart';
import 'package:itime/widgets/drawer_custom.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

NetworkUtil _netUtil = new NetworkUtil();
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  List dataNhanVien = new List();
  SharedPreferences references;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      drawer: new DrawerCustom(),
      appBar: new AppBar(
        backgroundColor: new HexColor("CC0000"),
        title: new Text("IZITIME"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search),
            onPressed: () {},
          ),
          new IconButton(
            icon: new Icon(Icons.notifications),
            onPressed: () {
              Navigator.of(context).pushNamed("/notification");
            },
          ),
        ],
      ),
      body: new ListView(
        children: [
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Container(
              width: double.infinity,
              height: 140,
              decoration: new BoxDecoration(
                color: new HexColor("FFFFFF"),
                borderRadius: new BorderRadius.all(
                  new Radius.circular(10.0), //         <--- border radius here
                ),
              ),
              child: new Image.asset(
                'assets/images/timekeeper.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          new Container(
            width: double.infinity,
            height: 280.0,
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(
                        'Thống kê',
                        style: new TextStyle(
                          fontSize: kTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      new Text('xem thêm >'),
                    ],
                  ),
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      flex: 1,
                      child: new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new GestureDetector(
                          onTap: () {},
                          child: new Container(
                            decoration: new BoxDecoration(
                              gradient: new LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [
                                    0.2,
                                    0.4,
                                    0.6,
                                    0.9
                                  ],
                                  colors: [
                                    new HexColor("0995E2"),
                                    new HexColor("26C6DA"),
                                    new HexColor("80DEEA"),
                                    new HexColor("B1E9F0")
                                  ]),
                              borderRadius: new BorderRadius.all(
                                new Radius.circular(
                                  10.0,
                                ), //         <--- border radius here
                              ),
                            ),
                            height: 100,
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Text(
                                    'Ngày làm',
                                    style: new TextStyle(
                                      color: new HexColor("FFFFFF"),
                                      fontSize: kTextSize,
                                    ),
                                  ),
                                ),
                                new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Text(
                                    '500',
                                    style: new TextStyle(
                                      color: new HexColor("FFFFFF"),
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    new Expanded(
                      flex: 1,
                      child: new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Container(
                          decoration: new BoxDecoration(
                            gradient: new LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [
                                  0.2,
                                  0.4,
                                  0.6,
                                  0.9
                                ],
                                colors: [
                                  new HexColor("F94261"),
                                  new HexColor("E81E63"),
                                  new HexColor("EC407A"),
                                  new HexColor("F48FB1")
                                ]),
                            borderRadius: new BorderRadius.all(
                              new Radius.circular(
                                10.0,
                              ), //         <--- border radius here
                            ),
                          ),
                          height: 100,
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  'Ngày nghỉ',
                                  style: new TextStyle(
                                    color: new HexColor("FFFFFF"),
                                    fontSize: kTextSize,
                                  ),
                                ),
                              ),
                              new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  '20',
                                  style: new TextStyle(
                                    color: new HexColor("FFFFFF"),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      flex: 1,
                      child: new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Container(
                          decoration: new BoxDecoration(
                            gradient: new LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [
                                  0.2,
                                  0.4,
                                  0.6,
                                  0.9
                                ],
                                colors: [
                                  new HexColor("2E7D32"),
                                  new HexColor("388E3C"),
                                  new HexColor("66BB6A"),
                                  new HexColor("A5D6A7")
                                ]),
                            borderRadius: new BorderRadius.all(
                              new Radius.circular(
                                10.0,
                              ), //         <--- border radius here
                            ),
                          ),
                          height: 100,
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  'Số lần trễ',
                                  style: new TextStyle(
                                    color: new HexColor("FFFFFF"),
                                    fontSize: kTextSize,
                                  ),
                                ),
                              ),
                              new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  '10',
                                  style: new TextStyle(
                                    color: new HexColor("FFFFFF"),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    new Expanded(
                      flex: 1,
                      child: new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Container(
                          decoration: new BoxDecoration(
                            // color: new Hexcolor("F57C3C"),
                            gradient: new LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [
                                  0.2,
                                  0.4,
                                  0.6,
                                  0.9
                                ],
                                colors: [
                                  new HexColor("F57C3C"),
                                  new HexColor("FF6D00"),
                                  new HexColor("FFCC80"),
                                  new HexColor("FFB74D")
                                ]),
                            borderRadius: new BorderRadius.all(
                              new Radius.circular(
                                10.0,
                              ), //         <--- border radius here
                            ),
                          ),
                          height: 100,
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  'Thưởng đi sớm',
                                  style: new TextStyle(
                                    color: new HexColor("FFFFFF"),
                                    fontSize: kTextSize,
                                  ),
                                ),
                              ),
                              new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  '2000000',
                                  style: new TextStyle(
                                    color: new HexColor("FFFFFF"),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          new Container(
            width: double.infinity,
            height: 400.0,
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(
                        'Hoạt động',
                        style: new TextStyle(
                          fontSize: kTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      new Text('xem thêm >'),
                    ],
                  ),
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      flex: 1,
                      child: new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new GestureDetector(
                          onTap: () {
                            showAlertWarning(
                              context: context,
                              content:
                              "Trước khi điểm danh bạn hãy kiểm tra định vị để chúng tôi biết vị trí.",
                              root: "/check-in",
                              height: 130.0,
                            );
                          },
                          child: new Container(
                            decoration: new BoxDecoration(
                              color: new HexColor("FFFFFF"),
                              borderRadius: new BorderRadius.all(
                                new Radius.circular(
                                    10.0), //         <--- border radius here
                              ),
                              boxShadow: [
                                new BoxShadow(
                                    blurRadius: 5,
                                    color: new HexColor("CC0000"),
                                    offset: Offset(1, 2))
                              ],
                            ),
                            height: 100,
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new CircleAvatar(
                                    backgroundImage: new NetworkImage(
                                        'https://images.pexels.com/photos/736716/pexels-photo-736716.jpeg?auto=compress&cs=tinysrgb&h=350'),
                                    radius: 24.0,
                                  ),
                                ),
                                new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Text('Điểm danh'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    new Expanded(
                      flex: 1,
                      child: new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new GestureDetector(
                          onTap: () {
//                            Navigator.of(context).push(
//                              new MaterialPageRoute(
//                                builder: (context) => new TakeLeaveList(),
//                              ),
//                            );
                          },
                          child: new Container(
                            decoration: new BoxDecoration(
                              color: new HexColor("FFFFFF"),
                              borderRadius: new BorderRadius.all(
                                new Radius.circular(
                                    10.0), //         <--- border radius here
                              ),
                              boxShadow: [
                                new BoxShadow(
                                    blurRadius: 5,
                                    color: new HexColor("CC0000"),
                                    offset: Offset(1, 2))
                              ],
                            ),
                            height: 100,
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new CircleAvatar(
                                    backgroundImage: new ExactAssetImage(
                                        'assets/icons/xin-nghi.png'),
                                    radius: 24.0,
                                    backgroundColor: new HexColor("E9EBEE"),
                                  ),
                                ),
                                new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Text('Xin nghỉ'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    new Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed("/report");
                        },
                        child: new Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Container(
                            decoration: new BoxDecoration(
                              color: new HexColor("FFFFFF"),
                              borderRadius: new BorderRadius.all(
                                new Radius.circular(
                                    10.0), //         <--- border radius here
                              ),
                              boxShadow: [
                                new BoxShadow(
                                    blurRadius: 5,
                                    color: new HexColor("CC0000"),
                                    offset: Offset(1, 2))
                              ],
                            ),
                            height: 100,
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new CircleAvatar(
                                    backgroundImage: new ExactAssetImage(
                                        'assets/icons/bao-cao.png'),
                                    radius: 24.0,
                                    backgroundColor: new HexColor("E9EBEE"),
                                  ),
                                ),
                                new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Text('Báo cáo'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed("/reward");
                        },
                        child: new Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Container(
                            decoration: new BoxDecoration(
                              color: new HexColor("FFFFFF"),
                              borderRadius: new BorderRadius.all(
                                new Radius.circular(
                                    10.0), //         <--- border radius here
                              ),
                              boxShadow: [
                                new BoxShadow(
                                    blurRadius: 5,
                                    color: new HexColor("CC0000"),
                                    offset: Offset(1, 2))
                              ],
                            ),
                            height: 100,
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new CircleAvatar(
                                    backgroundImage: new ExactAssetImage(
                                        'assets/icons/reward.png'),
                                    radius: 24.0,
                                    backgroundColor: new HexColor("E9EBEE"),
                                  ),
                                ),
                                new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Text('Đổi thưởng'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    new Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed("/task_schedule");
                        },
                        child: new Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Container(
                            decoration: new BoxDecoration(
                              color: new HexColor("FFFFFF"),
                              borderRadius: new BorderRadius.all(
                                new Radius.circular(
                                    10.0), //         <--- border radius here
                              ),
                              boxShadow: [
                                new BoxShadow(
                                    blurRadius: 5,
                                    color: new HexColor("CC0000"),
                                    offset: Offset(1, 2))
                              ],
                            ),
                            height: 100,
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new CircleAvatar(
                                    radius: 24.0,
                                    backgroundImage: new ExactAssetImage(
                                      'assets/icons/len-lich.png',
                                    ),
                                    backgroundColor: new HexColor("E9EBEE"),
                                  ),
                                ),
                                new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Text('Lên lịch'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    new Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed("/shift-works");
                        },
                        child: new Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Container(
                            decoration: new BoxDecoration(
                              color: new HexColor("FFFFFF"),
                              borderRadius: new BorderRadius.all(
                                new Radius.circular(
                                    10.0), //         <--- border radius here
                              ),
                              boxShadow: [
                                new BoxShadow(
                                    blurRadius: 5,
                                    color: new HexColor("CC0000"),
                                    offset: Offset(1, 2))
                              ],
                            ),
                            height: 100,
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new CircleAvatar(
                                    radius: 24.0,
                                    backgroundImage: new ExactAssetImage(
                                      'assets/icons/gio-lam.png',
                                    ),
                                    backgroundColor: new HexColor("E9EBEE"),
                                  ),
                                ),
                                new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Text('Giờ làm'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed("/salary");
                        },
                        child: new Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Container(
                            decoration: new BoxDecoration(
                              color: new HexColor("FFFFFF"),
                              borderRadius: new BorderRadius.all(
                                new Radius.circular(
                                    10.0), //         <--- border radius here
                              ),
                              boxShadow: [
                                new BoxShadow(
                                    blurRadius: 5,
                                    color: new HexColor("CC0000"),
                                    offset: Offset(1, 2))
                              ],
                            ),
                            height: 100,
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new CircleAvatar(
                                    radius: 24.0,
                                    backgroundImage: new ExactAssetImage(
                                      'assets/icons/cham-cong.png',
                                    ),
                                    backgroundColor: new HexColor("E9EBEE"),
                                  ),
                                ),
                                new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Text('Chấm công'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    new Expanded(
                      flex: 1,
                      child: new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Container(
                          decoration: new BoxDecoration(
                            color: new HexColor("FFFFFF"),
                            borderRadius: new BorderRadius.all(
                              new Radius.circular(
                                  10.0), //         <--- border radius here
                            ),
                            boxShadow: [
                              new BoxShadow(
                                  blurRadius: 5,
                                  color: new HexColor("CC0000"),
                                  offset: Offset(1, 2))
                            ],
                          ),
                          height: 100,
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new CircleAvatar(
                                  backgroundImage: new ExactAssetImage(
                                    'assets/icons/hoat-dong.png',
                                  ),
                                  backgroundColor: new HexColor("E9EBEE"),
                                  radius: 24.0,
                                ),
                              ),
                              new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text('Hoạt động'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    new Expanded(
                      flex: 1,
                      child: new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Container(
                          decoration: new BoxDecoration(
                            color: new HexColor("FFFFFF"),
                            borderRadius: new BorderRadius.all(
                              new Radius.circular(
                                  10.0), //         <--- border radius here
                            ),
                            boxShadow: [
                              new BoxShadow(
                                  blurRadius: 5,
                                  color: new HexColor("CC0000"),
                                  offset: Offset(1, 2))
                            ],
                          ),
                          height: 100,
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new CircleAvatar(
                                  backgroundImage: new ExactAssetImage(
                                      'assets/icons/other.png'),
                                  radius: 24.0,
                                  backgroundColor: new HexColor("E9EBEE"),
                                ),
                              ),
                              new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text('Khác'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showAlertWarning(
      {BuildContext context, String content, String root, double height}) {
    showDialog(
      context: context,
      child: new CupertinoAlertDialog(
        // title: new Text("Thông báo"),
        content: Container(
          // height: 150,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/icons/warning.png", width: 50, height: 50),
              SizedBox(height: 10.0),
              Text(
                content,
                style: TextStyle(fontSize: kTextSize),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed(root);
            },
            child: new Text("OK, Tôi đã hiểu"),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: new Text("Rời khỏi"),
          ),
        ],
      ),
    );
  }

}
