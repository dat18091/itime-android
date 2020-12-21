import 'package:flutter/material.dart';

class ShiftThumbnail extends StatefulWidget {
  @override
  _ShiftThumbnailState createState() => _ShiftThumbnailState();
}

class _ShiftThumbnailState extends State<ShiftThumbnail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: new Image(
        image: new AssetImage("assets/icons/shift.png"),
        width: 100,
        height: 100,
      ),
    );
  }
}
