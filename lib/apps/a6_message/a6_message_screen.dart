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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      drawer: new DrawerCustom(),
      appBar: new AppBar(
        backgroundColor: HexColor("CC0000"),
        automaticallyImplyLeading: false,
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
            onPressed: () {},
          ),
        ],
      ),
      body: new Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CircleAvatar(
                              radius: 26,
                              backgroundImage:
                              AssetImage('assets/images/datnguyen.jpg'),
                            ),
                          ),
                          Positioned(
                            right: 2,
                            child: Container(
                                height: 25,
                                decoration: new BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(30.0),
                                  border: Border.all(
                                      color: HexColor("FFFFFF"), width: 1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: Text(
                                    "9",
                                    style: TextStyle(
                                      fontSize: kTextSize - 3,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor('FFFFFF'),
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      Text(
                        "Chats",
                        style: TextStyle(
                          fontSize: kTextSize + 4,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: Icon(Icons.camera_alt, color: Colors.black),
                      ),
                      SizedBox(width: 10),
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: Icon(Icons.edit, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: new BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                width: MediaQuery.of(context).size.width - 40,
                child: TextField(
                  decoration: new InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.add, size: 24, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: AssetImage("assets/users/user3.jpg"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: AssetImage("assets/users/user2.jpg"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: AssetImage("assets/users/user1.jpg"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
