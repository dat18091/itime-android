import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:itime/apps/a9_take_leave/a9_belate_screen.dart';
import 'package:itime/apps/a9_take_leave/a9_leavesoon_screen.dart';
import 'package:itime/apps/a9_take_leave/a9_takeleave_screen.dart';
import 'package:itime/commons/constants.dart';

class SelectTakeLeave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget _buildTakeLeaveBox({
      String title,
      IconData icon,
      String buttonName,
      Function onPress,
    }) {
      return new Padding(
        padding: const EdgeInsets.all(5.0),
        child: new Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
                  0.2,
                  0.6,
                  0.6,
                  0.9
                ],
                colors: [
                  new HexColor("0995E2"),
                  new HexColor("26C6DA"),
                  new HexColor("80DEEA"),
                  new HexColor("B1E9F0")
                ]),
            borderRadius: new BorderRadius.all(
              new Radius.circular(10.0), //         <--- border radius here
            ),
          ),
          width: double.infinity,
          height: size.height / 6,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Text(
                      "${title}",
                      style: new TextStyle(
                        fontSize: kTextSize,
                        fontWeight: FontWeight.bold,
                        color: new HexColor("FFFFFF"),
                      ),
                    ),
                    new Icon(icon, color: new HexColor("0995E2"), size: 30),
                  ],
                ),
              ),
              new Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                child: new Container(
                  width: size.width / 3,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      // side: BorderSide()
                    ),
                    textColor: Colors.white,
                    color: new HexColor('FF9F1A'),
                    // padding: const EdgeInsets.all(8.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new Text(
                          "${buttonName}",
                          style: new TextStyle(fontSize: kTextSize),
                        ),
                      ],
                    ),
                    onPressed: onPress,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return new SafeArea(
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: new HexColor("CC0000"),
          // elevation: 0.0,
          title: new Text("Xin nghỉ"),
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
            _buildTakeLeaveBox(
              title: "Xin nghỉ phép",
              icon: Icons.access_alarm,
              buttonName: "Áp dụng",
              onPress: () {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (context) => new TakeLeave(),
                  ),
                );
              },
            ),
            _buildTakeLeaveBox(
              title: "Xin đi trễ",
              icon: Icons.access_alarm,
              buttonName: "Áp dụng",
              onPress: () {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (context) => new BeLate(),
                  ),
                );
              },
            ),
            _buildTakeLeaveBox(
              title: "Xin về sớm",
              icon: Icons.access_alarm,
              buttonName: "Áp dụng",
              onPress: () {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (context) => new LeaveSoon(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
