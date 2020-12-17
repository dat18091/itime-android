import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:itime/commons/constants.dart';
import 'package:itime/models/Employee.dart';
import 'package:itime/utils/network_util.dart';
import 'package:itime/widgets/drawer_custom.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

NetworkUtil _netUtil = new NetworkUtil();
class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
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
    return new SafeArea(
      child: new Scaffold(
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
          title: new Text("IZICHAT"),
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
        body: new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              new FutureBuilder(
                future: _layDuLieuNhanVien(),
                  builder: (context, snapshot){
                    return new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: new Row(
                            children: [
                              new Stack(
                                children: [
                                  new Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: new CircleAvatar(
                                      radius: 26,
                                      backgroundImage: new AssetImage(
                                          !snapshot.hasData
                                              ? "assets/images/photo.png"
                                              : "assets/images/${_employee[0]['hinh_anh_nhan_vien']}"),
                                    ),
                                  ),
                                  new Positioned(
                                    right: 2,
                                    child: new Container(
                                      height: 25,
                                      decoration: new BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: new BorderRadius.circular(30.0),
                                        border: new Border.all(
                                          color: new HexColor("FFFFFF"),
                                          width: 1,
                                        ),
                                      ),
                                      child: new Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        child: new Text(
                                          "9",
                                          style: new TextStyle(
                                            fontSize: kTextSize - 3,
                                            fontWeight: FontWeight.w600,
                                            color: new HexColor('FFFFFF'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              new Text(
                                "Chats",
                                style: new TextStyle(
                                  fontSize: kTextSize + 4,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        new Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: new Row(
                            children: [
                              new CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                child: Icon(Icons.camera_alt, color: Colors.black),
                              ),
                              new SizedBox(width: 10),
                              new CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                child: Icon(Icons.edit, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
              ),
              new SizedBox(height: 10),
              new Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: new Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: new BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: new BorderRadius.circular(20.0),
                  ),
                  width: MediaQuery.of(context).size.width - 40,
                  child: new TextField(
                    decoration: new InputDecoration(
                      hintText: "Search",
                      border: InputBorder.none,
                      icon: new Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              new SizedBox(height: 10),
              new Container(
                height: 80,
                child: new ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    new Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: new CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.grey[300],
                        child: new Icon(Icons.add, size: 24, color: Colors.black),
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: new AssetImage("assets/users/user3.jpg"),
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: new AssetImage("assets/users/user2.jpg"),
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: new AssetImage("assets/users/user1.jpg"),
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: new AssetImage("assets/users/user3.jpg"),
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: new AssetImage("assets/users/user2.jpg"),
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: new AssetImage("assets/users/user1.jpg"),
                      ),
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
