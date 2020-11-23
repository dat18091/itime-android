import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:itime/models/Employee.dart';
import 'package:itime/services/data_services.dart';
import 'package:itime/utils/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

NetworkUtil _netUtil = new NetworkUtil();

class DrawerCustom extends StatefulWidget {
  @override
  _DrawerCustomState createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  SharedPreferences references;
  List _employee = new List<Employee>();

  @override
  void initState() {
    super.initState();
    _layDuLieuNhanVien();
  }

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text(
                _employee.length > 0
                    ? _employee[0]['ten_nhan_vien'].toString()
                    : '',
                style: new TextStyle(color: new HexColor("FFFFFF"))),
            accountEmail: new Text(
                _employee.length > 0
                    ? _employee[0]['email_nhan_vien'].toString()
                    : '',
                style: new TextStyle(color: new HexColor("FFFFFF"))),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new ExactAssetImage('assets/images/avatar-drawer.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage(
                    "https://randomuser.me/api/portraits/men/46.jpg")),
          ),
          new ListTile(
              leading: new Icon(Icons.library_music),
              title: new Text("Chấm công"),
              onTap: () {
                Navigator.pop(context);
              }),
          new ListTile(
              leading: new Icon(Icons.movie),
              title: new Text("Xin nghỉ phép"),
              onTap: () {}),
          new ListTile(
              leading: new Icon(Icons.shopping_cart),
              title: new Text("Xin đi trễ, về sớm"),
              onTap: () {}),
          new ListTile(
              leading: new Icon(Icons.apps),
              title: new Text("Báo cáo"),
              onTap: () {
                Navigator.of(context).pushNamed("/report");
              }),
          new ListTile(
              leading: new Icon(Icons.dashboard),
              title: new Text("Nhắc nhở"),
              onTap: () {}),
          new ListTile(
              leading: new Icon(Icons.settings),
              title: new Text("Bảng lương"),
              onTap: () {}),
          new Divider(),
          new ListTile(
              leading: new Icon(Icons.info),
              title: new Text("Đổi mật khẩu"),
              onTap: () {}),
          new ListTile(
              leading: new Icon(Icons.power_settings_new),
              title: new Text("Đăng xuất"),
              onTap: () {
                Navigator.of(context).pushNamed("/log-in");
              }),
        ],
      ),
      // ),
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
