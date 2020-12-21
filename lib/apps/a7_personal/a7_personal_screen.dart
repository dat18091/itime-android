import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:itime/apps/a1_login/a1_login_screen.dart';
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
  SharedPreferences preferences;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("F6F6F6"),
//      drawer: new DrawerCustom(),
      appBar: AppBar(
        backgroundColor: HexColor("CC0000"),
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
        automaticallyImplyLeading: false,
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
      body: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text("Dat nguyen",
                style: TextStyle(
                  color: HexColor("FFFFFF"),
                  fontSize: kTextSize,
                )),
            accountEmail: new Text("dat18090@gmail.com",
                style: TextStyle(color: HexColor("FFFFFF"))),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new ExactAssetImage(
                    'assets/images/background-user-default-1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/men/46.jpg")),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(children: <Widget>[
              Icon(
                Icons.add_chart,
                color: Colors.pink[500],
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                "Báo cáo",
                style: TextStyle(fontSize: kTextSize),
              ),
            ]),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(children: <Widget>[
              Icon(
                Icons.add_to_home_screen_outlined,
                color: Colors.green,
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                "Quản lý phép",
                style: TextStyle(fontSize: kTextSize),
              ),
            ]),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(children: <Widget>[
              Icon(
                Icons.attach_money,
                color: Colors.purple,
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                "Phiếu lương",
                style: TextStyle(fontSize: kTextSize),
              ),
            ]),
          ),
          Divider(),
          Padding(
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
          new GestureDetector(
            onTap: () async {
              preferences = await SharedPreferences.getInstance();
              preferences.remove("maCongTy");
              preferences.remove("tenDangNhap");
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new LoginScreen(),
                ),
              );
            },
            child: Padding(
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
}
