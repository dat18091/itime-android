import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:itime/apps/a1_login/a1_login_screen.dart';
import 'package:itime/models/Employee.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
 * @author datnq
 * @Date: 23/11/2020
 *
 * Modification Logs
 * DATE   		AUTHOR 		DESCRIPTION
 * ------------------------------------
 * 23/11/2020	DatNQ		  drawer widget
 */
class DrawerCustom extends StatefulWidget {
  final String name;
  final String image;
  final String email;

  const DrawerCustom({Key key, this.name, this.image, this.email}) : super(key: key);
  @override
  _DrawerCustomState createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  SharedPreferences preferences;

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
              accountName: new Text('${widget.name}',
                  style: new TextStyle(color: new HexColor("FFFFFF"))),
              accountEmail: new Text('${widget.email}',
                  style: new TextStyle(color: new HexColor("FFFFFF"))),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new ExactAssetImage('assets/images/avatar-drawer.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              currentAccountPicture: new CircleAvatar(
                backgroundImage:
                    new AssetImage(widget.image),
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
            ),
          ],
        ),
        // ),
      ),
    );
  }
}
