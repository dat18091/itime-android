import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

import 'package:itime/commons/constants.dart';
import 'package:itime/models/Company.dart';
import 'package:itime/services/data_services.dart';
import 'package:itime/widgets/alert_dialog.dart';
import 'package:itime/widgets/tabbar_custom.dart';

import 'package:itime/apps/a2_register/a2_register_screen.dart';

/**
 * @author datnq
 * @Date: 23/11/2020
 *
 * Modification Logs
 * DATE   		AUTHOR 		DESCRIPTION
 * ------------------------------------
 * 23/11/2020	DatNQ		  login page
 */
DataServices _dataServices = new DataServices();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Get list from future
  Future<List<Company>> _futureGetAllCompanies;

  // Get list model
  List<Company> listCompanies = [];

  // Define base data type
  String _mySelection;

  // Define object from library
  SharedPreferences preferences;
  GlobalKey<FormState> _formKey = new GlobalKey();
  TextEditingController tenDangNhap = new TextEditingController();
  TextEditingController matKhau = new TextEditingController();

  // Define datetime
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');

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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Size size = MediaQuery.of(context).size;
    /**
     * Select company
     * */
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
                hintText: 'Nhập mật khẩu',
                hintStyle: new TextStyle(
                  color: bTextColor,
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
            if(_mySelection == '' || tenDangNhap.text == '' || matKhau.text == '') {
              print("check rỗng");
              showAlert(
                title: "Thông báo",
                content: "Tên đăng nhập hoặc mật khẩu không được để trống.",
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
            } else if(tenDangNhap.text.length > 20 || matKhau.text.length > 20){
              print("check quá ký tự");
              showAlert(
                title: "Thông báo",
                content: "Bạn đã nhập quá ký tự cho phép.",
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
            } else if(tenDangNhap.text.length > 20 || matKhau.text.length > 20) {
              print("check ký tự nhỏ");
              showAlert(
                title: "Thông báo",
                content: "Bạn đã quá ít ký tự.",
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
              _dataServices
                  .login(
                  idCompany: int.parse(_mySelection),
                  username: tenDangNhap.text,
                  password: matKhau.text)
                  .then((dynamic res) async{
                if (res.length > 0) {
                  preferences = await SharedPreferences.getInstance();
                  preferences.setString("tenDangNhap", tenDangNhap.text);
                  preferences.setString("maCongTy", _mySelection);
                  tenDangNhap.clear();
                  matKhau.clear();
                  print("đăng nhập thành công");
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
                    context: context,
                  );
                } else {
                  print("đăng nhập không thành công");
                  showAlert(
                    title: "Thông báo",
                    content: "Tên đăng nhập hoặc mật khẩu không đúng.",
                    onPress: () {
                      Navigator.pop(context);
                    },
                    subOnPress: null,
                    context: context,
                  );
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
}
