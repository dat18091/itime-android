import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:itime/commons/constants.dart';
import 'package:itime/models/Employee.dart';
import 'package:itime/utils/network_util.dart';
import 'package:itime/widgets/drawer_custom.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

NetworkUtil _netUtil = new NetworkUtil();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences references;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List _employee = new List<Employee>();

  @override
  void initState() {
    super.initState();
    _layDuLieuNhanVien();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget _buildActiveBox({String image, String title}) {
      return new Container(
        decoration: new BoxDecoration(
          color: new HexColor("FFFFFF"),
          borderRadius: new BorderRadius.all(
            new Radius.circular(10.0), //         <--- border radius here
          ),
          boxShadow: [
            new BoxShadow(
                blurRadius: 5,
                color: new HexColor("CC0000"),
                offset: Offset(1, 2))
          ],
        ),
        height: size.height / 6,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new CircleAvatar(
                backgroundImage: new ExactAssetImage('${image}'),
                radius: 24.0,
                backgroundColor: new HexColor("E9EBEE"),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text('${title}'),
            ),
          ],
        ),
      );
    }

    return new SafeArea(
      child: new Scaffold(
        key: _scaffoldKey,
        drawer: new FutureBuilder(
          future: _layDuLieuNhanVien(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new DrawerCustom(
                employee: new Employee(
                    tenNhanVien: _employee.length > 0
                        ? _employee[0]['ten_nhan_vien'].toString()
                        : '',
                    emailNhanVien: _employee.length > 0
                        ? _employee[0]['email_nhan_vien'].toString()
                        : '',
                    hinhAnhNhanVien: _employee[0]['hinh_anh_nhan_vien'] == ''
                        ? ""
                        : "assets/images/${_employee[0]['hinh_anh_nhan_vien']}"),
              );
            } else {
              return new Drawer();
            }
          },
        ),
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
        body: new SafeArea(
          child: new ListView(
            children: [
              new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Container(
                  width: double.infinity,
                  height: size.height / 4,
                  decoration: new BoxDecoration(
                    color: new HexColor("FFFFFF"),
                    borderRadius: new BorderRadius.all(
                      new Radius.circular(
                          10.0), //         <--- border radius here
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
                height: size.height / 2.6,
                child: new Column(
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.all(5.0),
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
                          new Text(
                            'xem thêm',
                            style: new TextStyle(
                              fontSize: kTextSize - 3,
                              color: HexColor("419DC6"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Row(
                      children: <Widget>[
                        new Expanded(
                          flex: 1,
                          child: new Padding(
                            padding: const EdgeInsets.all(5.0),
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
                                height: size.height / 7,
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    new Padding(
                                      padding: const EdgeInsets.all(5.0),
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
                            padding: const EdgeInsets.all(5.0),
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
                              height: size.height / 7,
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
                            padding: const EdgeInsets.all(5.0),
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
                              height: size.height / 7,
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
                            padding: const EdgeInsets.all(5.0),
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
                              height: size.height / 7,
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
                height: size.height / 1.5,
                child: new Column(
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.all(5.0),
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
                          new Text(
                            'xem thêm',
                            style: new TextStyle(
                              fontSize: kTextSize - 3,
                              color: HexColor("419DC6"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Row(
                      children: <Widget>[
                        new Expanded(
                          flex: 1,
                          child: new Padding(
                            padding: const EdgeInsets.all(5.0),
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
                              child: _buildActiveBox(
                                image: 'assets/icons/xin-nghi.png',
                                title: 'Điểm danh',
                              ),
                            ),
                          ),
                        ),
                        new Expanded(
                          flex: 1,
                          child: new Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: new GestureDetector(
                              onTap: () {
//                            Navigator.of(context).push(
//                              new MaterialPageRoute(
//                                builder: (context) => new TakeLeaveList(),
//                              ),
//                            );
                              },
                              child: _buildActiveBox(
                                image: 'assets/icons/bao-cao.png',
                                title: 'Báo cáo',
                              ),
                            ),
                          ),
                        ),
                        new Expanded(
                          flex: 1,
                          child: new Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: new GestureDetector(
                              onTap: () {},
                              child: _buildActiveBox(
                                image: 'assets/icons/xin-nghi.png',
                                title: 'Xin nghỉ',
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
                            padding: const EdgeInsets.all(5.0),
                            child: new GestureDetector(
                              onTap: () {},
                              child: _buildActiveBox(
                                image: 'assets/icons/reward.png',
                                title: 'Đổi thưởng',
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
                              padding: const EdgeInsets.all(5.0),
                              child: _buildActiveBox(
                                image: 'assets/icons/len-lich.png',
                                title: 'Lên lịch',
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
                              padding: const EdgeInsets.all(5.0),
                              child: _buildActiveBox(
                                image: 'assets/icons/gio-lam.png',
                                title: 'Giờ làm',
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
                              padding: const EdgeInsets.all(5.0),
                              child: _buildActiveBox(
                                image: 'assets/icons/hoat-dong.png',
                                title: 'Hoat động',
                              ),
                            ),
                          ),
                        ),
                        new Expanded(
                          flex: 1,
                          child: new Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: _buildActiveBox(
                              image: 'assets/icons/gio-lam.png',
                              title: 'Giờ làm',
                            ),
                          ),
                        ),
                        new Expanded(
                          flex: 1,
                          child: new Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: _buildActiveBox(
                              image: 'assets/icons/other.png',
                              title: 'Khác',
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
        ),
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

  Future<String> _layDuLieuNhanVien() async {
    references = await SharedPreferences.getInstance();
    Map param = {
      'what': 110,
      'ten_dang_nhap': references.getString('tenDangNhap'),
    };
    final url = BASE_URL_GET + '?input=' + jsonEncode(param);
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    if (mounted) {
      setState(() {
        _employee = json.decode(res.body);
      });
    }
    return "Success";
  }
}
