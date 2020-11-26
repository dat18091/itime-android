import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:itime/commons/constants.dart';

class NotificationBox extends StatefulWidget {

  @override
  _NotificationBoxState createState() => _NotificationBoxState();
}

class _NotificationBoxState extends State<NotificationBox> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Padding(
        padding: const EdgeInsets.all(10.0),
        child: new Container(
          width: double.infinity,
          height: 150,
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(10.0),
            color: new HexColor("FFFFFF"),
          ),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Padding(
                padding:
                const EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
                child: new Container(
                  width: 30,
                  height: 30,
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(50),
                    // border: Border.all(color: Colors.blueAccent),
                  ),
                  child: new Image.asset(
                    'assets/icons/logo-itime96x96.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              new Container(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 10.0),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 140,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text(
                      'Đây là thông báo cho nhân viên',
                      style: new TextStyle(
                        fontSize: kTextSize - 2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    new Text(
                        'tui đã phê duyệt để nhân viên XXX được nghỉ nhưng mà nghỉ không lương nhé thanh niên, làm mà nghỉ nghỉ quài bực mình.'),
                    new Text(
                      '21-10-2020 12:13',
                      style: new TextStyle(
                        fontSize: kTextSize - 2,
                        color: Colors.blue,
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
}
