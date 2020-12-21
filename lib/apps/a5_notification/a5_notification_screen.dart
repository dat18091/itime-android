import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:itime/commons/constants.dart';
import 'package:itime/models/Employee.dart';
import 'package:itime/utils/network_util.dart';
import 'package:itime/widgets/drawer_custom.dart';
import 'package:itime/widgets/notification_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
//
//  final WebSocketChannel channel;
//
//  const NotificationManager({Key key, this.channel}) : super(key: key);

  @override
  _NotificationManagerState createState() => _NotificationManagerState();
}

class _NotificationManagerState extends State<NotificationManager> {
  // Get list from future
  Future<List<Employee>> _futureGetEmployeeByUserName;

  // Get list model
  List<Employee> listEmployees = [];

  // Define base data type
  String _mySelection;
  String userName;
  String idCompany;

  // Define object from library
  SharedPreferences preferences;
  GlobalKey<FormState> _formKey = new GlobalKey();
  TextEditingController contentController = new TextEditingController();

  // Define datetime
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');

  // Sub function
  Future<String> getUserName() async {
    preferences = await SharedPreferences.getInstance();
    userName = preferences.getString('tenDangNhap');
    return userName;
  }

  Future<String> getIdCompany() async {
    preferences = await SharedPreferences.getInstance();
    idCompany = preferences.getString('maCongTy');
    return idCompany;
  }

  @override
  void initState() {
    super.initState();
//    _layDuLieuNhanVien();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      key: _scaffoldKey,
      backgroundColor: new HexColor("F6F6F6"),
//      drawer: new FutureBuilder(
//        future: _futureGetEmployeeByUserName,
//        builder: (context, snapshot) {
//          if (snapshot.hasData) {
//            return new DrawerCustom(
//              name:
//                  listEmployees[0].name.length > 0 ? listEmployees[0].name : '',
//              email: listEmployees[0].email.length > 0
//                  ? listEmployees[0].email
//                  : '',
//              image: listEmployees[0].image == ''
//                  ? ""
//                  : "assets/images/${listEmployees[0].image}",
//            );
//          } else {
//            return Drawer();
//          }
//        },
//      ),
      appBar: new AppBar(
        backgroundColor: new HexColor("CC0000"),
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
      body: new SafeArea(
        child: new ListView(
          children: [
//        StreamBuilder(
//        stream: widget.channel.stream,
//          builder: (context, snapshot) {
//            return Text(snapshot.hasData ? '${snapshot.data}' : '');
//          },
//        ),
            new NotificationBox(),
            new NotificationBox(),
            new NotificationBox(),
          ],
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
}
