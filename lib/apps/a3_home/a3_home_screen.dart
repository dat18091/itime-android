import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:itime/apps/a10_report/a10_report_screen.dart';
import 'package:itime/apps/a11_reward/a11_reward_screen.dart';
import 'package:itime/apps/a12_schedule/a12_schedule_screen.dart';
import 'package:itime/apps/a13_shift_work/a13_shiftworks_screen.dart';
import 'package:itime/apps/a14_salary/a14_salary_screen.dart';
import 'package:itime/apps/a8_attendance/a8_attendance_screen.dart';
import 'package:itime/apps/a9_take_leave/a9_select_takeleave_screen.dart';
import 'package:itime/commons/constants.dart';
import 'package:itime/models/Employee.dart';
import 'package:itime/services/data_services.dart';
import 'package:itime/widgets/ShimmerCustom.dart';
import 'package:itime/widgets/drawer_custom.dart';
import 'package:shared_preferences/shared_preferences.dart';

DataServices _dataServices = new DataServices();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  // Get list from future
  Future<List<Employee>> _futureGetEmployeeByUserName;
  Future<dynamic> _futureCountAttendance;
  Future<dynamic> _futureCountTakeLeave;

  // Get list model
  List<Employee> listEmployees = [];

  // Define base data type
  String userName;
  String idCompany;
  int countAttendance = 0;
  int countTakeLeave = 0;

  // Define object from library
  SharedPreferences preferences;

  // Define datetime

  // sub function
  Future<String> getUserName() async {
    preferences = await SharedPreferences.getInstance();
    userName = preferences.getString('tenDangNhap');
    return userName;
  }

  Future<String> getIdCompany() async {
    preferences = await SharedPreferences.getInstance();
    idCompany = preferences.getString('maCongTy');
    return idCompany;
  }

  @override
  void initState() {
    super.initState();
    // lay ten dang nhap
    getUserName()
        .then((username) {
          userName = username;
          print(userName);
        })
        .catchError((error) => print("${error.toString()}"))
        .whenComplete(() {
          // khi hoan thanh lay ma nhan vien
          getIdCompany().then((idcompany) {
            idCompany = idcompany;
            print(idCompany);
            // khi hoan thanh lay du lieu nhan vien
            _futureGetEmployeeByUserName = _dataServices
                .getEmployeeDataByUserName(
                    idCompany: int.parse(idCompany), userName: userName)
                .then((value) {
                  setState(() {
                    listEmployees = value;
                  });
                })
                .catchError((error) => print("${error.toString()}"))
                .whenComplete(() {
                  // khi hoàn thành đếm số ngày nghỉ
                  _futureCountAttendance = _dataServices
                      .countAttendances(
                          idCompany: int.parse(idCompany),
                          idEmployee: int.parse(listEmployees[0].id))
                      .then((dynamic res) {
                    setState(() {
                      countAttendance =
                          int.parse(res[0]['CountTakeLeave'].toString());
                      print("diem danh "+countAttendance.toString());
                    });
                  });
                  print("next active");
                  _futureCountTakeLeave = _dataServices
                      .countTakeLeave(
                          idCompany: int.parse(idCompany),
                          idEmployee: int.parse(listEmployees[0].id))
                      .then((dynamic takeLeave) {
                    setState(() {
                      countTakeLeave =
                          int.parse(takeLeave[0]['TakeLeave'].toString());
                      print("ngay nghi "+countTakeLeave.toString());
                    });
                  });
                });
          }).whenComplete(() => print("ma cong ty " + idCompany));
        })
        .whenComplete(() => print("ten dang nhap " + userName));
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
//        drawer: new FutureBuilder(
//          future: _futureGetEmployeeByUserName,
//          builder: (context, snapshot) {
//            if (snapshot.hasData) {
//              return new DrawerCustom(
//                name: listEmployees[0].name.length > 0
//                    ? listEmployees[0].name
//                    : '',
//                email: listEmployees[0].email.length > 0
//                    ? listEmployees[0].email
//                    : '',
//                image: listEmployees[0].image == ''
//                    ? ""
//                    : "assets/images/${listEmployees[0].image}",
//              );
//            } else if (snapshot.hasError) {
//              return Text("${snapshot.error}");
//            } else if (!snapshot.hasData) {
//              return new Drawer();
//            } else {
//              return new Drawer();
//            }
//          },
//        ),
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: new HexColor("CC0000"),
          title: Row(
            children: [
              new Image.asset(
                'assets/icons/logo-itime96x96.png',
                width: 30,
                height: 30,
              ),
              new SizedBox(
                width: 5,
              ),
              new Text("IZITIME"),
            ],
          ),
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
                        new FutureBuilder(
                          future: _futureCountAttendance,
                          builder: (context, snapshot) {
                            return new Expanded(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                            '${countAttendance.toString()}',
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
                            );
                          },
                        ),
                        new FutureBuilder(
                          future: _futureCountTakeLeave,
                          builder: (context, snapshot){
                            return new Expanded(
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
                                          '${countTakeLeave.toString()}',
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
                            );
                          },
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
//                                showAlertWarning(
//                                  context: context,
//                                  content:
//                                      "Trước khi điểm danh bạn hãy kiểm tra định vị để chúng tôi biết vị trí.",
//                                  root: "/check-in",
//                                  height: 130.0,
//                                );
                                Navigator.of(context).push(
                                  new MaterialPageRoute(
                                    builder: (context) =>
                                        new AttendanceScreen(),
                                  ),
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
                                Navigator.of(context).push(
                                  new MaterialPageRoute(
                                    builder: (context) =>
                                    new ReportSummary(),
                                  ),
                                );
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
                              onTap: () {
                                Navigator.of(context).push(
                                  new MaterialPageRoute(
                                    builder: (context) => new SelectTakeLeave(),
                                  ),
                                );
                              },
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
                              onTap: () {
                                Navigator.of(context).push(
                                  new MaterialPageRoute(
                                    builder: (context) => new RewardScreen(),
                                  ),
                                );
                              },
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
                              Navigator.of(context).push(
                                new MaterialPageRoute(
                                  builder: (context) => new TaskSchedule(),
                                ),
                              );
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
                              Navigator.of(context).push(
                                new MaterialPageRoute(
                                  builder: (context) => new ShiftWork(),
                                ),
                              );
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
                          child: new GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(
                                new MaterialPageRoute(
                                  builder: (context) => new SalaryScreen(),
                                ),
                              );
                            },
                            child: new Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: _buildActiveBox(
                                image: 'assets/icons/cham-cong.png',
                                title: 'Chấm công',
                              ),
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
}
