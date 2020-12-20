import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:itime/commons/constants.dart';
import 'package:itime/models/Employee.dart';
import 'package:itime/services/data_services.dart';
import 'package:itime/utils/network_util.dart';
import 'package:itime/widgets/alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

DataServices _dataServices = new DataServices();
class LeaveSoon extends StatefulWidget {
  @override
  _LeaveSoonState createState() => _LeaveSoonState();
}

class _LeaveSoonState extends State<LeaveSoon> {
  // Get list from future

  // Get list model
  var _listDataLeaveSoonReasons = List();
  var _listShifts = List();
  List<Employee> listEmployees = [];

  // Define base data type
  String _shift;
  String idCompany;
  String leaveSoonReason;

  // Define object from library
  SharedPreferences references;
  GlobalKey<FormState> _formKey = new GlobalKey();

  TextEditingController _dateLeaveSoonController = new TextEditingController();
  TextEditingController _contentController = new TextEditingController();
  TextEditingController _hourOutController = new TextEditingController();

  // Define datetime
  DateTime dateBeLate = DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
  var now = new DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay picked;

  // Sub function
  Future<String> getIdCompany() async {
    references = await SharedPreferences.getInstance();
    idCompany = references.getString('maCongTy');
    return idCompany;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataLeaveSoonReasonId();
    _getDataShifts();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget _selectDateLeaveSoon() {
      return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            alignment: Alignment.centerLeft,
            decoration: new BoxDecoration(
              color: new HexColor("FFCDD2"),
              borderRadius: new BorderRadius.circular(30.0),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6.0,
                  offset: new Offset(0, 2),
                ),
              ],
            ),
            height: size.height / 13,
            child: new TextFormField(
              style: new TextStyle(
                color: bTextColor,
                fontSize: kTextSize - 2,
              ),
              onTap: () async {
                final DateTime picked = await showDatePicker(
                    context: context,
                    initialDate: dateBeLate,
                    firstDate: DateTime(2019, 8),
                    lastDate: DateTime(2100));
                if (picked != null && picked != dateBeLate)
                  setState(() {
                    dateBeLate = picked;
                    var date =
                        "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
                    _dateLeaveSoonController.text = date;
                  });
              },
              decoration: new InputDecoration(
                border: InputBorder.none,
                contentPadding: new EdgeInsets.only(top: 14.0),
                prefixIcon: new Icon(
                  Icons.calendar_today,
                  color: new HexColor('4D5156'),
                ),
                hintText: 'Ngày xin về sớm',
                hintStyle: new TextStyle(
                  color: bTextColor,
                  fontSize: kTextSize - 2,
                ),
              ),
              controller: _dateLeaveSoonController,
            ),
          ),
        ],
      );
    }

    Widget _selectHourLeaveSoon() {
      return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            alignment: Alignment.centerLeft,
            decoration: new BoxDecoration(
              color: new HexColor("FFCDD2"),
              borderRadius: new BorderRadius.circular(30.0),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6.0,
                  offset: new Offset(0, 2),
                ),
              ],
            ),
            height: size.height / 13,
            child: new TextFormField(
              style: new TextStyle(
                color: bTextColor,
                fontSize: kTextSize - 2,
              ),
              onTap: () async {
                picked =
                await showTimePicker(context: context, initialTime: _time);
                setState(() {
                  _time = picked;
                  var date = "${picked.hour}:${picked.minute}";
                  _hourOutController.text = date;
                });
              },
              decoration: new InputDecoration(
                border: InputBorder.none,
                contentPadding: new EdgeInsets.only(top: 14.0),
                prefixIcon: new Icon(
                  Icons.calendar_today,
                  color: new HexColor('4D5156'),
                ),
                hintText: 'Giờ ra',
                hintStyle: new TextStyle(
                  color: bTextColor,
                  fontSize: kTextSize - 2,
                ),
              ),
              controller: _hourOutController,
            ),
          ),
        ],
      );
    }

    Widget _selectShifts() {
      return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            alignment: Alignment.centerLeft,
            decoration: new BoxDecoration(
              color: new HexColor("FFCDD2"),
              borderRadius: new BorderRadius.circular(30.0),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6.0,
                  offset: new Offset(0, 2),
                ),
              ],
            ),
            height: size.height / 13,
            padding: new EdgeInsets.only(left: 15.0, right: 15.0),
            child: new DropdownButtonHideUnderline(
              child: new DropdownButton<String>(
                isExpanded: true,
                isDense: false,
                items: _listShifts.map((item) {
                  return new DropdownMenuItem(
                    child: new Text(
                      '${item['name']}',
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 3,
                    ),
                    value: item['id'].toString(),
                  );
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    _shift = newVal;
                  });
                },
                value: _shift,
                hint: new Text("-- Chọn ca làm --"),
              ),
            ),
          ),
        ],
      );
    }

    Widget _selectDataLeaveSoonReasonId() {
      return new FutureBuilder(
          future: _getDataLeaveSoonReasonId(),
          builder: (context, snapshot) {
            return new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  alignment: Alignment.centerLeft,
                  decoration: new BoxDecoration(
                    color: new HexColor("FFCDD2"),
                    borderRadius: new BorderRadius.circular(30.0),
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6.0,
                        offset: new Offset(0, 2),
                      ),
                    ],
                  ),
                  height: size.height / 13,
                  padding: new EdgeInsets.only(left: 15.0, right: 15.0),
                  child: new DropdownButtonHideUnderline(
                    child: new DropdownButton<String>(
                      isExpanded: true,
                      isDense: false,
                      items: _listDataLeaveSoonReasons.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(
                            '${item['name']}',
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 3,
                          ),
                          value: item['id'].toString(),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          leaveSoonReason = newVal;
                        });
                      },
                      value: leaveSoonReason,
                      hint: new Text("-- Chọn lý do về sớm --"),
                    ),
                  ),
                ),
              ],
            );
          });
    }

    Widget _buildContentLeaveSoon() {
      return new Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
        child: new Container(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          height: size.height / 7,
          child: new TextFormField(
            textAlignVertical: TextAlignVertical.top,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            decoration: new InputDecoration(
              hintText: "Nội dung về sớm",
              hintStyle: TextStyle(color: Colors.black26),
              border: InputBorder.none,
              labelStyle: TextStyle(color: Colors.black),
            ),
            textAlign: TextAlign.start,
            style: new TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
            controller: _contentController,
          ),
          decoration: new BoxDecoration(
            color: new HexColor("FFFFFF"),
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              new BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 5,
                offset: new Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildSendRequest() {
      return new Container(
        padding: new EdgeInsets.symmetric(vertical: 20.0),
        width: double.infinity,
        child: new RaisedButton(
          elevation: 5.0,
          onPressed: () async {
            references = await SharedPreferences.getInstance();
            _dataServices
                .getEmployeeDataByUserName(
              idCompany: int.parse(references.getString("maCongTy")),
              userName: references.getString("tenDangNhap"),
            )
                .then((value) {
              listEmployees = value;
            })
                .catchError((error) => print("${error.toString()}"))
                .whenComplete(() {
              print("mã công ty " + references.getString("maCongTy"));
              print("mã nhân viên " + listEmployees[0].id);
              print("mã vùng " + listEmployees[0].areaId);
              print("mã chi nhánh " + listEmployees[0].branchId);
              print("mã phòng ban " + listEmployees[0].departmentId);
              print("mã chức danh " + listEmployees[0].positionId);
              print(DateFormat('yyyy-MM-dd').format(dateBeLate));
              print(_hourOutController.text);
              print(int.parse(leaveSoonReason));
              print(_contentController.text);
              print(_shift);

              _dataServices
                  .sendRequestLeaveSoon(
                  idCompany:
                  int.parse(references.getString("maCongTy")), //
                  idEmloyee: int.parse(listEmployees[0].id), //
                  idArea: int.parse(listEmployees[0].areaId), //
                  idBranch: int.parse(listEmployees[0].branchId), //
                  idDepartment:
                  int.parse(listEmployees[0].departmentId), //
                  idPosition: int.parse(listEmployees[0].positionId), //
                  idShift: int.parse(_shift), //
                  content: _contentController.text, //
                  dateLeaveSoon:
                  DateFormat('yyyy-MM-dd').format(dateBeLate), //
                  hourOut: _hourOutController.text, //
                  idLeaveSoonReason: int.parse(leaveSoonReason), //
                  reason: '' //
              )
                  .then((dynamic res) {
                if (res.length > 0) {
                  print("thanh cong 1");
                } else {
                  setState(() {
                    print("clear data");
                    dateBeLate = null;
                    _hourOutController.clear();
//                    _hourOnController.clear();
                    _contentController.clear();
                    leaveSoonReason = null;
                    _shift = null;
                    _contentController.clear();
                  });
                  showAlert(
                    title: "Thông báo",
                    content: "Gửi yêu cầu thành công.",
                    onPress: () {
                      Navigator.of(context).pop();
                    },
                    subOnPress: null,
                    context: context,
                  );
                }
              })
                  .whenComplete(() {});
            });
          },
          padding: new EdgeInsets.all(15.0),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          color: Colors.white,
          child: new Text(
            'GỬI YÊU CẦU',
            style: new TextStyle(
              color: new HexColor("FF4E44"),
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return new Form(
      key: _formKey,
      child: new SafeArea(
        child: new Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor("CC0000"),
            // elevation: 0.0,
            title: Text("Xin đi trễ"),
            actions: <Widget>[
              IconButton(
                icon: new Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: new Icon(Icons.notifications),
                onPressed: () {},
              ),
            ],
          ),
          body: new AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: new GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: new Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  new Positioned(
                    top: 0,
                    left: 0,
                    child: new Image.asset(
                      "assets/images/main_top.png",
                      width: size.width * 0.35,
                    ),
                  ),
                  new Positioned(
                    bottom: 0,
                    right: 0,
                    child: new Image.asset(
                      "assets/images/login_bottom.png",
                      width: size.width * 0.4,
                    ),
                  ),
                  new Container(
                    height: double.infinity,
                    child: new SingleChildScrollView(
                      physics: new AlwaysScrollableScrollPhysics(),
                      padding: new EdgeInsets.symmetric(
                        horizontal: 35.0,
                        vertical: 20.0,
                      ),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _selectDateLeaveSoon(),
                          new SizedBox(height: 10.0),
                          _selectHourLeaveSoon(),
                          new SizedBox(height: 10.0),
                          _selectShifts(),
                          new SizedBox(height: 10.0),
                          _selectDataLeaveSoonReasonId(),
                          new SizedBox(height: 10.0),
                          _buildContentLeaveSoon(),
                          _buildSendRequest(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String> _getDataLeaveSoonReasonId() async {
    references = await SharedPreferences.getInstance();
    Map param = {
      'what': 1107,
      'company_id': references.getString('maCongTy'),
      'status': 0,
    };
    final url = BASE_URL_GET + '?input=' + jsonEncode(param);
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    if (mounted) {
      setState(() {
        _listDataLeaveSoonReasons = json.decode(res.body);
      });
    }
    return "success";
  }

  Future<String> _getDataShifts() async {
    references = await SharedPreferences.getInstance();
    Map param = {
      'what': 1507,
      'company_id': references.getString('maCongTy'),
      'status': 0,
    };
    final url = BASE_URL_GET + '?input=' + jsonEncode(param);
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    if (mounted) {
      setState(() {
        _listShifts = json.decode(res.body);
      });
    }

    return "success";
  }
}
