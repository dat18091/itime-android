import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:itime/commons/constants.dart';
import 'package:itime/models/Employee.dart';
import 'package:itime/utils/network_util.dart';
import 'package:itime/widgets/drawer_custom.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

/**
 * @author datnq
 * @Date: 26/11/2020
 *
 * Modification Logs
 * DATE   		AUTHOR 		DESCRIPTION
 * ------------------------------------
 * 26/11/2020	DatNQ		  profile
 */
NetworkUtil _netUtil = new NetworkUtil();
class PersonalScreen extends StatefulWidget {
  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
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
      backgroundColor: new HexColor("F6F6F6"),
      drawer: new FutureBuilder(
        future: _layDuLieuNhanVien(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new DrawerCustom(
              employee: new Employee(
                  name: _employee.length > 0
                      ? _employee[0]['name'].toString()
                      : '',
                  email: _employee.length > 0
                      ? _employee[0]['email'].toString()
                      : '',
                  image: _employee[0]['image'] == ''
                      ? ""
                      : "assets/images/${_employee[0]['image']}"),
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
            onPressed: () {},
          ),
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new FutureBuilder(
            future: _layDuLieuNhanVien(),
            builder: (context, snapshot) {
              return new UserAccountsDrawerHeader(
                accountName: new Text(
                  !snapshot.hasData
                      ? ""
                      : "${_employee[0]['ten_nhan_vien']}",
                  style: new TextStyle(
                    color: new HexColor("FFFFFF"),
                    fontSize: kTextSize,
                  ),
                ),
                accountEmail: new Text(
                  !snapshot.hasData
                      ? ""
                      : "${_employee[0]['email_nhan_vien']}",
                  style: new TextStyle(
                    color: new HexColor("FFFFFF"),
                  ),
                ),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new ExactAssetImage(
                        'assets/images/background-user-default-1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: new AssetImage(
                    !snapshot.hasData
                        ? "assets/images/photo.png"
                        : "assets/images/${_employee[0]['hinh_anh_nhan_vien']}",
                  ),
                ),
              );
            },
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: new Row(children: <Widget>[
              new Icon(
                Icons.add_chart,
                color: Colors.pink[500],
                size: 30,
              ),
              new SizedBox(width: 10),
              new Text(
                "Báo cáo",
                style: new TextStyle(fontSize: kTextSize),
              ),
            ]),
          ),
          new Divider(),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: new Row(children: <Widget>[
              new Icon(
                Icons.add_to_home_screen_outlined,
                color: Colors.green,
                size: 30,
              ),
              new SizedBox(width: 10),
              new Text(
                "Quản lý phép",
                style: new TextStyle(fontSize: kTextSize),
              ),
            ]),
          ),
          new Divider(),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: new Row(children: <Widget>[
              new Icon(
                Icons.attach_money,
                color: Colors.purple,
                size: 30,
              ),
              new SizedBox(width: 10),
              new Text(
                "Phiếu lương",
                style: new TextStyle(fontSize: kTextSize),
              ),
            ]),
          ),
          new Divider(),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(children: <Widget>[
              Icon(
                Icons.person_outline,
                color: HexColor("026B94"),
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                "Thiết lập tài khoản",
                style: TextStyle(fontSize: kTextSize),
              ),
            ]),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(children: <Widget>[
              Icon(
                Icons.lock_open,
                color: HexColor("E96A68"),
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                "Kích hoạt trạng thái",
                style: TextStyle(fontSize: kTextSize),
              ),
            ]),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(children: <Widget>[
              Icon(
                Icons.list,
                color: HexColor("C99F3C"),
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                "Điều khoản chính sách",
                style: TextStyle(fontSize: kTextSize),
              ),
            ]),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(children: <Widget>[
              Icon(
                Icons.error,
                color: HexColor("2E39DA"),
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                "Trợ giúp",
                style: TextStyle(fontSize: kTextSize),
              ),
            ]),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(children: <Widget>[
              Icon(
                Icons.star,
                color: Colors.orange,
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                "Đánh giá IziTime",
                style: TextStyle(fontSize: kTextSize),
              ),
            ]),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(children: <Widget>[
              Icon(
                Icons.card_giftcard,
                color: HexColor("31A8CF"),
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                "Ưu đãi",
                style: TextStyle(fontSize: kTextSize),
              ),
            ]),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(children: <Widget>[
              Icon(
                Icons.cancel_outlined,
                color: HexColor("2D304D"),
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                "Báo lỗi",
                style: TextStyle(fontSize: kTextSize),
              ),
            ]),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(children: <Widget>[
              Icon(
                Icons.power_settings_new,
                color: Colors.red,
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                "Đăng xuất",
                style: TextStyle(fontSize: kTextSize),
              ),
            ]),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(children: <Widget>[
              Text(
                "Phiên bản hiện tại: ",
                style: TextStyle(fontSize: kTextSize),
              ),
              Text(
                "1.0.0",
                style: TextStyle(fontSize: kTextSize),
              ),
            ]),
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
