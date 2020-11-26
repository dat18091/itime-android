import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:itime/apps/a1_login/a1_login_screen.dart';
import 'package:itime/commons/constants.dart';
import 'package:itime/commons/special_convert.dart';
import 'package:itime/models/Company.dart';
import 'package:itime/services/data_services.dart';
import 'package:itime/utils/network_util.dart';

/**
 * @author datnq
 * @Date: 23/11/2020
 *
 * Modification Logs
 * DATE   		AUTHOR 		DESCRIPTION
 * ------------------------------------
 * 23/11/2020	DatNQ		  register page
 */
NetworkUtil _netUtil = new NetworkUtil();

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = new GlobalKey();

  TextEditingController tenNhanVien = new TextEditingController();
  TextEditingController tenDangNhap = new TextEditingController();
  TextEditingController emailNhanVien = new TextEditingController();
  TextEditingController soDienThoaiNhanVien = new TextEditingController();
  TextEditingController matKhau = new TextEditingController();

  String _mySelection;
  var _companies = new List<Company>();

  String _name;
  String _phone;
  String _email;
  String _password;

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

    Widget _buildFullnameInput() {
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
                hintText: 'Nhập tên đầy đủ',
                hintStyle: new TextStyle(
                  color: wTextColor,
                  fontSize: kTextSize - 2,
                ),
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Name is required.';
                }
              },
              onSaved: (String value) {
                _name = value;
              },
              controller: tenNhanVien,
            ),
          ),
        ],
      );
    }

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

    Widget _buildPhoneInput() {
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
              keyboardType: TextInputType.phone,
              style: new TextStyle(
                color: wTextColor,
                fontSize: kTextSize - 2,
              ),
              decoration: new InputDecoration(
                border: InputBorder.none,
                contentPadding: new EdgeInsets.only(top: 14.0),
                prefixIcon: new Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                hintText: 'Nhập số điện thoại',
                hintStyle: new TextStyle(
                  color: wTextColor,
                  fontSize: kTextSize - 2,
                ),
              ),
              controller: soDienThoaiNhanVien,
            ),
          ),
        ],
      );
    }

    Widget _buildEmailInput() {
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
              keyboardType: TextInputType.emailAddress,
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
                hintText: 'Nhập vào email',
                hintStyle: new TextStyle(
                  color: wTextColor,
                  fontSize: kTextSize - 2,
                ),
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Email is required';
                }

                if (!RegExp(
                        "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
                    .hasMatch(value)) {
                  return 'Enter a valid email address';
                }
                // validator has to return something :)
                return null;
              },
              onSaved: (String value) {
                _email = value;
              },
              controller: emailNhanVien,
            ),
          ),
        ],
      );
    }

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
                hintText: 'Nhập vào mật khẩu',
                hintStyle: new TextStyle(
                  color: wTextColor,
                  fontSize: kTextSize - 2,
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Password is required';
                }
              },
              onSaved: (String value) {
                _password = value;
              },
              controller: matKhau,
            ),
          ),
        ],
      );
    }

    Widget _buildRegisterBtn() {
      return new Container(
        padding: new EdgeInsets.symmetric(vertical: 20.0),
        width: double.infinity,
        child: new RaisedButton(
          elevation: 5.0,
          onPressed: () {
            register(context);
          },
          padding: new EdgeInsets.all(15.0),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          color: Colors.white,
          child: new Text(
            'ĐĂNG KÝ',
            style: new TextStyle(
              color: new HexColor("FF4E44"),
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      );
    }

    Widget _buildLoginBtn() {
      return new GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new LoginScreen(),
            ),
          );
        },
        child: new RichText(
          text: new TextSpan(
            children: [
              new TextSpan(
                text: 'Đã có tài khoản? ',
                style: new TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              new TextSpan(
                text: 'Đăng Nhập',
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
                          _selectCompany(),
                          new SizedBox(height: 10.0),
                          _buildFullnameInput(),
                          new SizedBox(height: 10.0),
                          _buildUsernameInput(),
                          new SizedBox(height: 10.0),
                          _buildPhoneInput(),
                          new SizedBox(height: 10.0),
                          _buildEmailInput(),
                          new SizedBox(height: 10.0),
                          _buildPasswordInput(),
                          _buildRegisterBtn(),
                          _buildLoginBtn(),
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

  void register(BuildContext context) async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Map parameters = {
        'what': 108,
        'ten_nhan_vien': tenNhanVien.text,
        'ten_dang_nhap': tenDangNhap.text,
        'email_nhan_vien': emailNhanVien.text,
        'so_dien_thoai_nhan_vien': soDienThoaiNhanVien.text,
        'mat_khau': convertStringToMD5(matKhau.text),
        'hoat_dong': 1,
        'quyen_truong_phong': 1,
        'created_at': formatter.format(now),
        'ma_cong_ty': _mySelection,
      };
      var input = jsonEncode(parameters);
      print(input);
      _netUtil.get(input).then(
        (dynamic res) {
          tenNhanVien.clear();
          tenDangNhap.clear();
          matKhau.clear();
          emailNhanVien.clear();
          tenNhanVien.clear();
          showAlert(
            title: "Thông báo",
            content: "Đăng ký thành công.",
            onPress: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new LoginScreen(),
                ),
              );
            },
            subOnPress: null,
          );
        },
      );
    }
  }

  void checkValueExists() async {
    Map parameters = {
      'what': 107,
      'ten_dang_nhap': tenDangNhap.text,
      'email_nhan_vien': emailNhanVien.text,
      'so_dien_thoai_nhan_vien': soDienThoaiNhanVien.text,
    };
    print(parameters);
    var input = jsonEncode(parameters);
    print(input);
    _netUtil.get(input).then((dynamic res) async {
      if (res.length > 0) {
        //tai khoan da ton tai
        showDialog(
          context: context,
          child: new CupertinoAlertDialog(
            // title: new Text("Thông báo"),
            content: new Container(
              // height: 150,
              height: 120,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image.asset("assets/icons/successful.png", width: 50, height: 50),
                  new SizedBox(height: 10.0),
                  new Text(
                    "Tài khoản đã tồn tại.",
                    style: new TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text("OK"),
              ),
            ],
          ),
        );
      } else {
        register(context);
      }
    });
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
