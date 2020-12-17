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
import 'package:itime/widgets/alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
DataServices _dataServices = new DataServices();

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Get list from future
  Future<List<Company>> _futureGetAllCompanies;

  // Get list model
  List<Company> listCompanies = [];

  // Define base data type
  String _mySelection;

  // Define object from library
  SharedPreferences references;
  GlobalKey<FormState> _formKey = new GlobalKey();
  TextEditingController tenNhanVien = new TextEditingController();
  TextEditingController tenDangNhap = new TextEditingController();
  TextEditingController emailNhanVien = new TextEditingController();
  TextEditingController soDienThoaiNhanVien = new TextEditingController();
  TextEditingController matKhau = new TextEditingController();

  // Define datetime
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');

  // sub function
  bool checkEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool checkPhoneNumber(String phone) {
    return RegExp(r"(^(?:[+0]9)?[0-9]{10,12}$)").hasMatch(phone);
  }

  @override
  void initState() {
    super.initState();
    // Get all companies
    _futureGetAllCompanies = _dataServices
        .getAllCompanies()
        .then((value) {
          listCompanies = value;
        })
        .catchError((error) => print("${error}"))
        .whenComplete(() => print("done"));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // WIDGET SELECT COMPANY
    Widget _selectCompany() {
      return new FutureBuilder(
        future: _futureGetAllCompanies,
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
                    items: listCompanies.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(
                          "${item.name}",
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
    // END WIDGET SELECT COMPANY

    // WIDGET INPUT FULLNAME
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
                color: bTextColor,
                fontSize: kTextSize - 2,
              ),
              decoration: new InputDecoration(
                border: InputBorder.none,
                contentPadding: new EdgeInsets.only(top: 14.0),
                prefixIcon: new Icon(
                  Icons.person,
                  color: bTextColor,
                ),
                hintText: 'Nhập tên đầy đủ',
                hintStyle: new TextStyle(
                  color: bTextColor,
                  fontSize: kTextSize - 2,
                ),
              ),
              controller: tenNhanVien,
            ),
          ),
        ],
      );
    }
    // END WIDGET INPUT FULLNAME

    // WIDGET INPUT USERNAME
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
                color: bTextColor,
                fontSize: kTextSize - 2,
              ),
              decoration: new InputDecoration(
                border: InputBorder.none,
                contentPadding: new EdgeInsets.only(top: 14.0),
                prefixIcon: new Icon(
                  Icons.person,
                  color: bTextColor,
                ),
                hintText: 'Nhập tên đăng nhập',
                hintStyle: new TextStyle(
                  color: bTextColor,
                  fontSize: kTextSize - 2,
                ),
              ),
              controller: tenDangNhap,
            ),
          ),
        ],
      );
    }
    // END WIDGET INPUT USERNAME

    // WIDGET INPUT PHONE
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
                color: bTextColor,
                fontSize: kTextSize - 2,
              ),
              decoration: new InputDecoration(
                border: InputBorder.none,
                contentPadding: new EdgeInsets.only(top: 14.0),
                prefixIcon: new Icon(
                  Icons.phone,
                  color: bTextColor,
                ),
                hintText: 'Nhập số điện thoại',
                hintStyle: new TextStyle(
                  color: bTextColor,
                  fontSize: kTextSize - 2,
                ),
              ),
              controller: soDienThoaiNhanVien,
            ),
          ),
        ],
      );
    }
    // END WIDGET INPUT PHONE

    // WIDGET INPUT EMAIL
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
                color: bTextColor,
                fontSize: kTextSize - 2,
              ),
              decoration: new InputDecoration(
                border: InputBorder.none,
                contentPadding: new EdgeInsets.only(top: 14.0),
                prefixIcon: new Icon(
                  Icons.person,
                  color: bTextColor,
                ),
                hintText: 'Nhập vào email',
                hintStyle: new TextStyle(
                  color: bTextColor,
                  fontSize: kTextSize - 2,
                ),
              ),
//              validator: (String value) {
//                if (value.isEmpty) {
//                  return 'Email is required';
//                }
//
//                if (!RegExp(
//                        "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
//                    .hasMatch(value)) {
//                  return 'Enter a valid email address';
//                }
//                // validator has to return something :)
//                return null;
//              },
//              onSaved: (String value) {
//                _email = value;
//              },
              controller: emailNhanVien,
            ),
          ),
        ],
      );
    }
    // END WIDGET INPUT EMAIL

    // WIDGET INPUT PASSWORD
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
                color: bTextColor,
                fontSize: kTextSize - 2,
              ),
              decoration: new InputDecoration(
                border: InputBorder.none,
                contentPadding: new EdgeInsets.only(top: 14.0),
                prefixIcon: new Icon(
                  Icons.lock,
                  color: bTextColor,
                ),
                hintText: 'Nhập vào mật khẩu',
                hintStyle: new TextStyle(
                  color: bTextColor,
                  fontSize: kTextSize - 2,
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
              controller: matKhau,
            ),
          ),
        ],
      );
    }
    // END WIDGET INPUT PASSWORD

    // BUILD BUTTON REGISTER
    Widget _buildRegisterBtn() {
      return new Container(
        padding: new EdgeInsets.symmetric(vertical: 20.0),
        width: double.infinity,
        child: new RaisedButton(
          elevation: 5.0,
          onPressed: () {
//            register(context);
            // check empty value
            if (tenDangNhap.text == '' ||
                emailNhanVien.text == '' ||
                tenNhanVien.text == '' ||
                soDienThoaiNhanVien.text == '' ||
                _mySelection == '') {
              print("check rỗng");
              showAlert(
                title: "Thông báo",
                content: "Vui lòng nhập đầy đủ tát cả các thông tin.",
                onPress: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new RegisterScreen(),
                    ),
                  );
                },
                subOnPress: null,
                context: context,
              );
              // check length value
            } else if (tenDangNhap.text.length > 20 ||
                emailNhanVien.text.length > 20 ||
                tenNhanVien.text.length > 20 ||
                soDienThoaiNhanVien.text.length > 20) {
              print("check nhiều ký tự");
              showAlert(
                title: "Thông báo",
                content: "Bạn đã nhập quá ký tự cho phép.",
                onPress: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new RegisterScreen(),
                    ),
                  );
                },
                subOnPress: null,
                context: context,
              );
              // check length value
            } else if (tenDangNhap.text.length < 5 ||
                emailNhanVien.text.length < 5 ||
                tenNhanVien.text.length < 5 ||
                soDienThoaiNhanVien.text.length < 5) {
              print("check ít ký tự");
              showAlert(
                title: "Thông báo",
                content: "Bạn đã nhập quá ít ký tự.",
                onPress: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new RegisterScreen(),
                    ),
                  );
                },
                subOnPress: null,
                context: context,
              );
              // check email
            } else if (!checkEmail(emailNhanVien.text)) {
              print("check email");
              showAlert(
                title: "Thông báo",
                content: "Email không đúng định dạng.",
                onPress: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new RegisterScreen(),
                    ),
                  );
                },
                subOnPress: null,
                context: context,
              );
              // check phone
            } else if (!checkPhoneNumber(soDienThoaiNhanVien.text)) {
              print("check số điện thoại");
              showAlert(
                title: "Thông báo",
                content: "Số điện thoại không đúng định dạng.",
                onPress: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new RegisterScreen(),
                    ),
                  );
                },
                subOnPress: null,
                context: context,
              );
            } else {
              // check exsist account
              _dataServices
                  .checkExistsAccountEmployees(
                      email: emailNhanVien.text,
                      phoneNumber: soDienThoaiNhanVien.text,
                      userName: tenDangNhap.text)
                  .then((dynamic res) {
                // if has account
                if (res.length > 1) {
                  showAlert(
                    title: "Thông báo",
                    content: "Tài khoản này đã tồn tại.",
                    onPress: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new RegisterScreen(),
                        ),
                      );
                    },
                    subOnPress: null,
                    context: context,
                  );
                } else {
                  // if not have account then register
                  _dataServices
                      .register(
                          idCompany: int.parse(_mySelection),
                          email: emailNhanVien.text,
                          phone: soDienThoaiNhanVien.text,
                          username: tenDangNhap.text,
                          password: matKhau.text,
                          fullname: tenNhanVien.text,
                          active: 1,
                          actingChief: 1)
                      .then((dynamic res) {
                    if (res.length > 0) {
                      showAlert(
                        title: "Thông báo",
                        content: "Đăng ký tài khoản thành công.",
                        onPress: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new LoginScreen(),
                            ),
                          );
                        },
                        subOnPress: null,
                        context: context,
                      );
                    } else {
                      showAlert(
                        title: "Thông báo",
                        content: "Đăng ký tài khoản thành công.",
                        onPress: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new RegisterScreen(),
                            ),
                          );
                        },
                        subOnPress: null,
                        context: context,
                      );
                    }
                  });
                }
              });
            }
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
    // END BUILD BUTTON REGISTER

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
}
