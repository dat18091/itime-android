import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget showAlert(
    {String title,
      String content,
      VoidCallback onPress,
      VoidCallback subOnPress, BuildContext context}) {
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