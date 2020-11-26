import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:itime/commons/constants.dart';
import 'package:itime/models/Employee.dart';
import 'package:itime/utils/network_util.dart';
import 'package:itime/widgets/drawer_custom.dart';
import 'package:itime/widgets/notification_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

/**
 * @author datnq
 * @Date: 23/11/2020
 *
 * Modification Logs
 * DATE   		AUTHOR 		DESCRIPTION
 * ------------------------------------
 * 26/11/2020	DatNQ		  notification
 */
NetworkUtil _netUtil = new NetworkUtil();
class NotificationManager extends StatefulWidget {
  @override
  _NotificationManagerState createState() => _NotificationManagerState();
}

class _NotificationManagerState extends State<NotificationManager> {
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
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: new HexColor("F6F6F6"),
      drawer: new FutureBuilder(
        future: _layDuLieuNhanVien(),
        builder: (context, snapshot){
          if(snapshot.hasData) {
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
                      : "assets/images/${_employee[0]['hinh_anh_nhan_vien']}"
              ),
            );
          }
          else {
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
            onPressed: () {},
          ),
        ],
      ),
      body: new SafeArea(
        child: new ListView(
          children: [
            new NotificationBox(),
            new NotificationBox(),
            new NotificationBox(),
          ],
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
    return "Success";
  }
}