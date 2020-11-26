import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:itime/apps/a2_register/a2_register_screen.dart';
import 'package:itime/apps/a3_home/a3_home_screen.dart';
import 'package:itime/commons/constants.dart';

import 'package:itime/commons/special_convert.dart';
import 'package:itime/models/Company.dart';
import 'package:itime/services/data_services.dart';
import 'package:itime/utils/network_util.dart';
import 'package:itime/widgets/tabbar_custom.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
 * @author datnq
 * @Date: 23/11/2020
 *
 * Modification Logs
 * DATE   		AUTHOR 		DESCRIPTION
 * ------------------------------------
 * 23/11/2020	DatNQ		  login page
 */
NetworkUtil _netUtil = new NetworkUtil();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = new GlobalKey();

  String _mySelection;
  var _companies = new List<Company>();

  TextEditingController tenDangNhap = new TextEditingController();
  TextEditingController matKhau = new TextEditingController();

  @override
  void initState() {
    super.initState();
    DataServices.getAllCompanies().then((company) {
      _companies = company;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    /**
     * Select company
     * */
    Widget _selectCompany() {
      return new FutureBuilder(
        future: DataServices.getAllCompanies(),
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
                    items: _companies.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(
                          "${item.tenCongTy}",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 3,
                        ),
                        value: item.id.toString(),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        _mySelection = newVal;
                      });
                    },
                    value: _mySelection,
                    hint: new Text("-- Chọn công ty --"),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    /**
     * Username
     * */
    Widget _buildUsernameInput() {
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
              keyboardType: TextInputType.text,
              style: new TextStyle(
                color: wTextColor,
                fontSize: kTextSize - 2,
              ),
              decoration: new InputDecoration(
                border: InputBorder.none,
                contentPadding: new EdgeInsets.only(top: 14.0),
                prefixIcon: new Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                hintText: 'Nhập tên đăng nhập',
                hintStyle: new TextStyle(
                  color: wTextColor,
                  fontSize: kTextSize - 2,
                ),
              ),
              controller: tenDangNhap,
            ),
          ),
        ],
      );
    }

    /**
     * Password
     * */
    Widget _buildPasswordInput() {
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
              obscureText: true,
              style: new TextStyle(
                color: wTextColor,
                fontSize: kTextSize - 2,
              ),
              decoration: new InputDecoration(
                border: InputBorder.none,
                contentPadding: new EdgeInsets.only(top: 14.0),
                prefixIcon: new Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                hintText: 'Nhập mật khẩu',
                hintStyle: new TextStyle(
                  color: wTextColor,
                  fontSize: kTextSize - 2,
                ),
              ),
              controller: matKhau,
            ),
          ),
        ],
      );
    }

    /**
     * Login button
     * */
    Widget _buildLoginBtn() {
      return new Container(
        padding: new EdgeInsets.symmetric(vertical: 20.0),
        width: double.infinity,
        child: new RaisedButton(
          elevation: 5.0,
          onPressed: () {
            login(context);
          },
          padding: new EdgeInsets.all(15.0),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          color: Colors.white,
          child: new Text(
            'ĐĂNG NHẬP',
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

    /**
     * Link register
     * */
    Widget _buildSignupBtn() {
      return new GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new RegisterScreen(),
            ),
          );
        },
        child: new RichText(
          text: new TextSpan(
            children: [
              new TextSpan(
                text: 'Chưa có tài khoản? ',
                style: new TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              new TextSpan(
                text: 'Đăng Ký',
                style: new TextStyle(
                  color: new HexColor("FF4E44"),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
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
                        vertical: 100.0,
                      ),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Image.asset(
                            "assets/images/timelab.png",
                            height: size.height * 0.25,
                          ),
                          new SizedBox(height: 10.0),
                          _selectCompany(),
                          new SizedBox(height: 10.0),
                          _buildUsernameInput(),
                          new SizedBox(height: 10.0),
                          _buildPasswordInput(),
                          _buildLoginBtn(),
                          _buildSignupBtn(),
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

  void login(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("tenDangNhap", tenDangNhap.text);
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Map parameters = {
        'what': 109,
        'ten_dang_nhap': tenDangNhap.text,
        'mat_khau': convertStringToMD5(matKhau.text),
        'ma_cong_ty': _mySelection,
      };
      print(parameters);
      _netUtil.get(jsonEncode(parameters)).then((dynamic res) {
        if (res.length > 0) {
          tenDangNhap.clear();
          matKhau.clear();
          showAlert(
            title: "Thông báo",
            content: "Đăng nhập thành công.",
            onPress: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new TabbarCustom(),
                ),
              );
            },
            subOnPress: null,
          );
        }
      });
    }
  }

  Widget showAlert(
      {String title,
      String content,
      VoidCallback onPress,
      VoidCallback subOnPress}) {
    showDialog(
      context: context,
      child: new CupertinoAlertDialog(
        title: new Text("${title}"),
        content: new Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new SizedBox(height: 10.0),
              new Text(
                "${content}",
                style: new TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            onPressed: onPress,
            child: new Text("OK"),
          ),
        ],
      ),
    );
  }
}
