import 'dart:async';
import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:itime/models/Employee.dart';
import 'package:itime/services/data_services.dart';
import 'package:itime/utils/network_util.dart';
import 'package:itime/widgets/alert_dialog.dart';
import 'package:itime/widgets/tabbar_custom.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

NetworkUtil _netUtil = new NetworkUtil();
DataServices _dataServices = DataServices();
class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  bool isActive = false;
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
  List _employee = new List<Employee>();
  SharedPreferences references;
  String _currentAddress;
  String _secondString;
  String _minuteString;
  String _hourString;

  List<Employee> _listEmployee = [];

  GlobalKey<FormState> _formKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
//    _layDuLieuNhanVien();
    _getUserLocation();
    _secondString = _formatSecond(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getSecondTime());
    _minuteString = _formatMinute(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getMinuteTime());
    _hourString = _formatHour(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getHourTime());
  }

  void _getSecondTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatSecond(now);
    setState(() {
      _secondString = formattedDateTime;
    });
  }

  void _getMinuteTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatMinute(now);
    setState(() {
      _minuteString = formattedDateTime;
    });
  }

  void _getHourTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatHour(now);
    setState(() {
      _hourString = formattedDateTime;
    });
  }

  String _formatSecond(DateTime dateTime) {
    return DateFormat('ss').format(dateTime);
  }

  String _formatMinute(DateTime dateTime) {
    return DateFormat('mm').format(dateTime);
  }

  String _formatHour(DateTime dateTime) {
    return DateFormat('HH').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
        backgroundColor: new HexColor("FFFFFF"),
        appBar: new AppBar(
          leading: new Builder(
            builder: (BuildContext context) {
              return new IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (context) => new TabbarCustom(),
                    ),
                  );
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          backgroundColor: new HexColor("CC0000"),
          elevation: 0.0,
          title: new Text("Điểm danh"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () {},
            ),
            new IconButton(
              icon: new Icon(Icons.notifications),
              onPressed: () {},
            ),
          ],
        ),
        body: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              new SizedBox(height: 20.0),
              new Center(
                child: new Text(
                  "Chào mừng bạn đến với IziTime",
                  style: new TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              new Center(
                // neu bam vao check in
                child: !isActive
                    ? new AvatarGlow(
                        startDelay: new Duration(milliseconds: 1000),
                        glowColor: new HexColor("CC0000"),
                        endRadius: 160.0,
                        duration: new Duration(milliseconds: 2000),
                        repeat: true,
                        showTwoGlows: true,
                        repeatPauseDuration: Duration(milliseconds: 100),
                        child: new MaterialButton(
                          onPressed: () async {
                            references = await SharedPreferences.getInstance();
                            String maCongTy = references.getString("maCongTy");
                            String tenDangNhap =
                                references.getString("tenDangNhap");
                            String maNhanVien =
                                references.getString("maNhanVien");
                            // check address
                            if (_currentAddress == null) {
                              showAlert(
                                title: 'Thông báo',
                                content: 'Bạn cần kiểm tra lại định vị GPS',
                                onPress: () => Navigator.of(context).pop(),
                                subOnPress: null,
                                context: context,
                              );
                            } else {
                              // get data employee
                              _dataServices
                                  .getEmployeeDataByUserName(
                                      idCompany: int.parse(maCongTy),
                                      userName: tenDangNhap)
                                  .then((dynamic res) {
                                print("get data employee");
                                if (res.length > 0) {
                                  // check exists attendances
                                  print(maNhanVien);
                                  _dataServices
                                      .checkExistsAttendances(
                                          idCompany: int.parse(maCongTy),
                                          idEmployee: int.parse(maNhanVien),
                                          status: int.parse('0'))
                                      .then((dynamic data) {
                                    print("check exists attendance");
                                    if (data.length < 0) {
                                      // check time attendances : not make
                                      // attendances
                                      _dataServices
                                          .checkInSubmit(
                                          status: 1,
                                          idCompany: int.parse(references
                                              .getString("maCongTy")),
                                          idEmployee: int.parse(references
                                              .getString("maNhanVien")),
                                          checkInImage: "",
                                          checkInLocal: _currentAddress,
                                          idPosition: int.parse(
                                              res[0].positionId.toString()),
                                          idDepartment: int.parse(
                                              res[0].departmentId.toString()),
                                          idBranch: int.parse(
                                              res[0].branchId.toString()),
                                          idArea: int.parse(
                                              res[0].areaId.toString()))
                                          .then((dynamic res) {
                                        if (res.length > 0) {
                                          showAlert(
                                            title: 'Thông báo',
                                            content: 'Điểm danh thành công.',
                                            onPress: () =>
                                                Navigator.of(context).pop(),
                                            subOnPress: null,
                                            context: context,
                                          );
                                        } else {
                                          showAlert(
                                            title: 'Thông báo',
                                            content: 'Điểm danh thành công.',
                                            onPress: () =>
                                                Navigator.of(context).pop(),
                                            subOnPress: null,
                                            context: context,
                                          );
                                        }
                                        setState(() {
                                          isActive = !isActive;
                                        });
                                      });
                                      // end attendances
                                    } else {
                                      showAlert(
                                        title: 'Thông báo',
                                        content:
                                            'Bạn đã điểm danh ngày hôm nay, vui lòng quay lại vào ngày mai.',
                                        onPress: () =>
                                            Navigator.of(context).pop(),
                                        subOnPress: null,
                                        context: context,
                                      );
                                    }
                                  });
                                  // end check exists attendances
                                } else {
                                  showAlert(
                                    title: 'Thông báo',
                                    content:
                                        'Bạn cần báo cho admin để điền thêm thông tin về bản thân.',
                                    onPress: () => Navigator.of(context).pop(),
                                    subOnPress: null,
                                    context: context,
                                  );
                                }
                              });
                              // end get data employee
                            }
                          },
                          elevation: 20.0,
                          shape: new CircleBorder(),
                          child: new Container(
                            width: 170.0,
                            height: 170.0,
                            alignment: Alignment.center,
                            decoration: new BoxDecoration(
                                color: new HexColor("CC0000"),
                                borderRadius: new BorderRadius.circular(160.0)),
                            child: new Text(
                              "Check in",
                              // "Check in",
                              style: new TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w800,
                                  color: new HexColor("FFFFFF")),
                            ),
                          ),
                        ),
                      )
                    //neu bam vao check out
                    : new AvatarGlow(
                        startDelay: new Duration(milliseconds: 1000),
                        glowColor: new HexColor("CC0000"),
                        endRadius: 160.0,
                        duration: new Duration(milliseconds: 2000),
                        repeat: true,
                        showTwoGlows: true,
                        repeatPauseDuration: new Duration(milliseconds: 100),
                        child: new MaterialButton(
                          onPressed: () {
                            print("Checkout");
//                            checkOutSubmit(context);
//                            _layDuLieuCheckin();
                            print(_currentAddress);
                            setState(() {
                              isActive = !isActive;
                            });
                          },
                          elevation: 20.0,
                          shape: new CircleBorder(),
                          child: new Container(
                            width: 170.0,
                            height: 170.0,
                            alignment: Alignment.center,
                            decoration: new BoxDecoration(
                              color: new HexColor("CC0000"),
                              borderRadius: new BorderRadius.circular(160.0),
                            ),
                            child: new Text(
                              "Check out",
                              style: new TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w800,
                                color: new HexColor("FFFFFF"),
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
              new SizedBox(height: 20.0),
              // Text(_secondString),
              new Center(
                child: new Container(
                  width: double.infinity,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        width: 50,
                        height: 50,
                        decoration: new BoxDecoration(
                          color: Colors.black,
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                        child: new Center(
                          child: new Text(
                            _hourString,
                            // hours.toString().padLeft(2, '0'),
                            style: new TextStyle(
                              fontSize: 25,
                              color: new HexColor("FFFFFF"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      new SizedBox(width: 5.0),
                      new Container(
                        width: 50,
                        height: 50,
                        decoration: new BoxDecoration(
                          color: Colors.black,
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                        child: new Center(
                          child: new Text(
                            _minuteString,
                            // minutes.toString().padLeft(2, '0'),
                            style: new TextStyle(
                              fontSize: 25,
                              color: new HexColor("FFFFFF"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      new SizedBox(width: 7.0),
                      new Container(
                        width: 50,
                        height: 50,
                        decoration: new BoxDecoration(
                          color: Colors.black,
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                        child: new Center(
                          child: new Text(
                            _secondString,
                            style: new TextStyle(
                              fontSize: 25,
                              color: new HexColor("FFFFFF"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//  Future<String> _layDuLieuNhanVien() async {
//    references = await SharedPreferences.getInstance();
//    Map param = {
//      'what': 110,
//      'ten_dang_nhap': references.getString('tenDangNhap'),
//    };
//    final url = BASE_URL_GET + '?input=' + jsonEncode(param);
//    var res = await http
//        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
//    if (mounted) {
//      setState(() {
//        _employee = json.decode(res.body);
//      });
//    }
//    return "Success";
//  }

  Future<void> checkInSubmit(BuildContext context) async {
    formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
    references = await SharedPreferences.getInstance();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Map parameters = {
        'what': 307,
        'ma_nhan_vien': references.getString("maNhanVien"),
        'ma_cong_ty': references.getString("maCongTy"),
        'ma_vung':
            _employee.length > 0 ? _employee[0]['ma_vung'].toString() : '',
        'ma_chi_nhanh':
            _employee.length > 0 ? _employee[0]['ma_chi_nhanh'].toString() : '',
        'ma_phong_ban':
            _employee.length > 0 ? _employee[0]['ma_phong_ban'].toString() : '',
        'ma_chuc_danh':
            _employee.length > 0 ? _employee[0]['ma_chuc_danh'].toString() : '',
        'check_in_time': formatter.format(now),
        'check_in_local': _currentAddress,
        'check_in_image': "",
        'status': isActive ? 0 : 1,
        'created_at': formatter.format(now),
      };
      var input = jsonEncode(parameters);
      _netUtil.get(input).then((dynamic res) {
//        Navigator.of(context).push(
//          new MaterialPageRoute(
//            builder: (context) =>
//            new AttendanceCamera(),
//          ),
//        );
      });
    }
  }

  void checkOutSubmit(BuildContext context) async {
    formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
    references = await SharedPreferences.getInstance();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Map parameters = {
        'what': 309,
        'check_out_time': formatter.format(now),
        'check_out_local': _currentAddress,
        'check_out_image': "",
        'status': 1,
        'updated_at': formatter.format(now),
        'id': references.getString("maDiemDanh"),
      };
      var input = jsonEncode(parameters);
      print(input);
      _netUtil.get(input).then((dynamic res) {
//        Navigator.of(context).push(
//          new MaterialPageRoute(
//            builder: (context) =>
//            new AttendanceCamera(),
//          ),
//        );
      });
    }
  }

  _getUserLocation() async {
    try {
      Position position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placemarks = await Geolocator().placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark placemark = placemarks[0];
      String completeAddress =
          '${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality} ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}';
      _currentAddress = completeAddress;
    } catch (e) {
      print(e);
    }
  }
}
