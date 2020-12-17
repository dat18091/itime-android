import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:itime/commons/constants.dart';
import 'package:itime/services/data_services.dart';
import 'package:itime/utils/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:itime/models/Datetakeleavetype.dart';
import 'package:itime/models/Employee.dart';

import 'package:http/http.dart' as http;

/**
 * @author datnq
 * @Date: 29/11/2020
 *
 * Modification Logs
 * DATE   		AUTHOR 		DESCRIPTION
 * ------------------------------------
 * 29/11/2020	DatNQ		  take leave
 */
NetworkUtil _netUtil = new NetworkUtil();
DataServices _dataServices = new DataServices();

class TakeLeave extends StatefulWidget {
  @override
  _TakeLeaveState createState() => _TakeLeaveState();
}

class _TakeLeaveState extends State<TakeLeave> {
  // Get list from future
  Future<List<Datetakeleavetype>> _futureGetDataDateTakeLeaveType;

  // Get list model
  var _listDateTakeLeaveTypes = List();
//  List<Datetakeleavetype> listDateTakeLeaveTypes = [];
  var _listTakeLeaveTypes = List();
  var _listTakeLeaveReasons = List();
  var _listShifts = List();
  List _employee = new List<Employee>();

  // Define base data type
  String _dateTakeLeaveTypes;
  String _takeLeaveTypes;
  String _takeLeaveReasons;
  String _shift;

  // Define object from library
  SharedPreferences references;
  GlobalKey<FormState> _formKey = new GlobalKey();

  TextEditingController _dateTakeLeaveController = new TextEditingController();
  TextEditingController _startDateController = new TextEditingController();
  TextEditingController _endDateController = new TextEditingController();
  TextEditingController _contentController = new TextEditingController();

  // Define datetime
  DateTime takeLeaveDate = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  var formatterDateType = new DateFormat('dd-MM-yyyy');
  var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
  var now = new DateTime.now();

  @override
  void initState() {
    super.initState();
    _getDataDateTakeLeaveTypes();
    _getDataTakeLeaveTypes();
    _getDataTakeLeaveReasons();
    _getDataShifts();
    _layDuLieuNhanVien();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget _selectDateTakeLeaveTypes() {
      return new FutureBuilder(
          future: _getDataDateTakeLeaveTypes(),
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
                      items: _listDateTakeLeaveTypes.map((item) {
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
                          _dateTakeLeaveTypes = newVal;
                        });
                      },
                      value: _dateTakeLeaveTypes,
                      hint: new Text("-- Chọn loại ngày nghỉ --"),
                    ),
                  ),
                ),
              ],
            );
          });
    }

    Widget _selectDateTakeLeave() {
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
                    initialDate: takeLeaveDate,
                    firstDate: DateTime(2019, 8),
                    lastDate: DateTime(2100));
                if (picked != null && picked != takeLeaveDate)
                  setState(() {
                    takeLeaveDate = picked;
                    var date =
                        "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
                    _dateTakeLeaveController.text = date;
                  });
              },
              decoration: new InputDecoration(
                border: InputBorder.none,
                contentPadding: new EdgeInsets.only(top: 14.0),
                prefixIcon: new Icon(
                  Icons.calendar_today,
                  color: new HexColor('4D5156'),
                ),
                hintText: 'Chọn ngày nghỉ',
                hintStyle: new TextStyle(
                  color: bTextColor,
                  fontSize: kTextSize - 2,
                ),
              ),
              controller: _dateTakeLeaveController,
            ),
          ),
        ],
      );
    }

    Widget _selectStartDate() {
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
                    initialDate: startDate,
                    firstDate: DateTime(2019, 8),
                    lastDate: DateTime(2100));
                if (picked != null && picked != startDate)
                  setState(() {
                    startDate = picked;
                    var date =
                        "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
                    _startDateController.text = date;
                  });
              },
              decoration: new InputDecoration(
                border: InputBorder.none,
                contentPadding: new EdgeInsets.only(top: 14.0),
                prefixIcon: new Icon(
                  Icons.calendar_today,
                  color: new HexColor('4D5156'),
                ),
                hintText: 'Ngày bắt đầu nghỉ',
                hintStyle: new TextStyle(
                  color: bTextColor,
                  fontSize: kTextSize - 2,
                ),
              ),
              controller: _startDateController,
            ),
          ),
        ],
      );
    }

    Widget _selectEndDate() {
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
                    initialDate: endDate,
                    firstDate: DateTime(2019, 8),
                    lastDate: DateTime(2100));
                if (picked != null && picked != endDate)
                  setState(() {
                    endDate = picked;
                    var date =
                        "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
                    _endDateController.text = date;
                  });
              },
              decoration: new InputDecoration(
                border: InputBorder.none,
                contentPadding: new EdgeInsets.only(top: 14.0),
                prefixIcon: new Icon(
                  Icons.calendar_today,
                  color: new HexColor('4D5156'),
                ),
                hintText: 'Ngày kết thúc nghỉ',
                hintStyle: new TextStyle(
                  color: bTextColor,
                  fontSize: kTextSize - 2,
                ),
              ),
              controller: _endDateController,
            ),
          ),
        ],
      );
    }

    Widget _buildSendRequest() {
      return new Container(
        padding: new EdgeInsets.symmetric(vertical: 20.0),
        width: double.infinity,
        child: new RaisedButton(
          elevation: 5.0,
          onPressed: () {
            sendRequestTakeLeave(context);
//            _dataServices
//                .insertDataIntoTakeLeave(
//                  idArea: int.parse(_employee[0]['ma_vung']),
//                  idBranch:int.parse( _employee[0]['ma_chi_nhanh']),
//                  idDepartment: int.parse(_employee[0]['ma_phong_ban']),
//                  idPosition: int.parse(_employee[0]['ma_chuc_danh']),
//                  idDateTakeLeaveType: int.parse(_dateTakeLeaveTypes),
//                  startDate: _startDateController.text,
//                  endDate: _endDateController.text,
//                  dateTakeLeave: _dateTakeLeaveController.text,
//                  idTakeLeaveTypes: int.parse(_takeLeaveTypes),
//                  idShift: int.parse(_shift),
//                  idTakeLeaveReason: int.parse(_takeLeaveReasons),
//                  reason: '',
//                  status: 0,
//                  content: _contentController.text,
//                )
//                .then((dynamic res) => print(res))
//                .catchError((error) => print("${error}"));
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

    Widget _selectTakeLeaveTypes() {
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
                items: _listTakeLeaveTypes.map((item) {
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
                    _takeLeaveTypes = newVal;
                  });
                },
                value: _takeLeaveTypes,
                hint: new Text("-- Chọn loại nghỉ --"),
              ),
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
                      '${item['ten_ca_lam']}',
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 3,
                    ),
                    value: item['ma_ca_lam'].toString(),
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

    Widget _selectTakeLeaveReasons() {
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
                items: _listTakeLeaveReasons.map((item) {
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
                    _takeLeaveReasons = newVal;
                  });
                },
                value: _takeLeaveReasons,
                hint: new Text("-- Chọn lý do nghỉ --"),
              ),
            ),
          ),
        ],
      );
    }

    Widget _buildContentTakeLeave() {
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
              hintText: "Nội dung nghỉ phép",
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

    return new Form(
      key: _formKey,
      child: new SafeArea(
        child: new Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor("CC0000"),
            // elevation: 0.0,
            title: Text("Xin nghỉ phép"),
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
                          new SizedBox(height: 10.0),
                          _selectDateTakeLeaveTypes(),
                          SizedBox(height: 10.0),
                          _dateTakeLeaveTypes == "1" ||
                                  _dateTakeLeaveTypes == null
                              ? _selectDateTakeLeave()
                              : Column(
                                  children: [
                                    _selectStartDate(),
                                    SizedBox(height: 10.0),
                                    _selectEndDate(),
                                  ],
                                ),
                          SizedBox(height: 10.0),
                          _selectTakeLeaveTypes(),
                          SizedBox(height: 10.0),
                          _takeLeaveTypes == "3"
                              ? Column(
                                  children: [
                                    _selectShifts(),
                                    SizedBox(height: 10.0),
                                  ],
                                )
                              : Visibility(
                                  child: Text("Gone"),
                                  visible: false,
                                ),
                          _selectTakeLeaveReasons(),
                          SizedBox(height: 10.0),
                          _buildContentTakeLeave(),
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
    references.setString("maNhanVien", _employee[0]["ma_nhan_vien"]);
    return "Success";
  }

  Future<String> _getDataDateTakeLeaveTypes() async {
    references = await SharedPreferences.getInstance();
    Map param = {
      'what': 407,
      'ma_cong_ty': references.getString('maCongTy'),
      'status': 0,
    };
    final url = BASE_URL_GET + '?input=' + jsonEncode(param);
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    if (mounted) {
      setState(() {
        _listDateTakeLeaveTypes = json.decode(res.body);
      });
    }
    return "success";
  }

  Future<String> _getDataTakeLeaveTypes() async {
    references = await SharedPreferences.getInstance();
    Map param = {
      'what': 507,
      'ma_cong_ty': references.getString('maCongTy'),
      'status': 0,
    };
    final url = BASE_URL_GET + '?input=' + jsonEncode(param);
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    if (mounted) {
      setState(() {
        _listTakeLeaveTypes = json.decode(res.body);
      });
    }

    return "success";
  }

  Future<String> _getDataShifts() async {
    references = await SharedPreferences.getInstance();
    Map param = {
      'what': 607,
      'ma_cong_ty': references.getString('maCongTy'),
      'trang_thai_ca_lam': 0,
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

  Future<String> _getDataTakeLeaveReasons() async {
    references = await SharedPreferences.getInstance();
    Map param = {
      'what': 707,
      'ma_cong_ty': references.getString('maCongTy'),
      'status': 0,
    };
    final url = BASE_URL_GET + '?input=' + jsonEncode(param);
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    if (mounted) {
      setState(() {
        _listTakeLeaveReasons = json.decode(res.body);
      });
    }
    return "success";
  }

  Future<void> sendRequestTakeLeave(BuildContext context) async {
    formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
    references = await SharedPreferences.getInstance();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Map parameters = {
        'what': 850,
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
        'idDateTakeLeaveType': _dateTakeLeaveTypes,
        'start_date': _startDateController.text,
        'end_date': _endDateController.text,
        'date_take_leave': _dateTakeLeaveController.text,
        'idTakeLeaveType': _takeLeaveTypes,
        'ma_ca_lam': _shift,
        'idTakeLeaveReason': _takeLeaveReasons,
        'reason': '',
        'content': _contentController.text,
        'status': 0,
        'created_at': formatter.format(now),
        'updated_at': formatter.format(now),
      };
      var input = jsonEncode(parameters);
      print("them take leave " + input);
      return _netUtil.get(input);
//      print(input);
//      _netUtil.get(input).then((response) {
//        setState(() {
//          print(response);
//          print("clear data");
//          _dateTakeLeaveTypes = null;
//          _startDateController.clear();
//          _endDateController.clear();
//          _dateTakeLeaveController.clear();
//          _takeLeaveTypes = null;
//          _shift = null;
//          _takeLeaveReasons = null;
//          _contentController.clear();
//        });
//      });
    }
  }
}
