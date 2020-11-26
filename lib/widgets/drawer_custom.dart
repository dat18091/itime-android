import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:itime/models/Employee.dart';
import 'package:itime/utils/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

/**
 * @author datnq
 * @Date: 23/11/2020
 *
 * Modification Logs
 * DATE   		AUTHOR 		DESCRIPTION
 * ------------------------------------
 * 23/11/2020	DatNQ		  drawer widget
 */
NetworkUtil _netUtil = new NetworkUtil();

class DrawerCustom extends StatefulWidget {
  final Employee employee;

  const DrawerCustom({Key key, this.employee}) : super(key: key);
  @override
  _DrawerCustomState createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Drawer(
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('${widget.employee.tenNhanVien}',
                  style: new TextStyle(color: new HexColor("FFFFFF"))),
              accountEmail: new Text('${widget.employee.emailNhanVien}',
                  style: new TextStyle(color: new HexColor("FFFFFF"))),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new ExactAssetImage('assets/images/avatar-drawer.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              currentAccountPicture: new CircleAvatar(
                backgroundImage:
                    new AssetImage(widget.employee.hinhAnhNhanVien),
              ),
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
              },
            ),
          ],
        ),
        // ),
      ),
    );
  }
}
