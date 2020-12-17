import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AttendanceCamera extends StatefulWidget {
  @override
  _AttendanceCameraState createState() => _AttendanceCameraState();
}

class _AttendanceCameraState extends State<AttendanceCamera> {

  TextEditingController contentController = new TextEditingController();
  int categoryStatus;

  File imageFile;
  String imageData;

  Future addCategory() async {
    var param = {
      'name': contentController.text,
      'image': imageData,
      'status': categoryStatus.toString(),
    };
    var res = await http.post("link");
  }

  choiceImage() async {
    var pickedImage = await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
      imageData = base64Encode(imageFile.readAsBytesSync());
      return imageData;
    } else {
      return null;
    }
  }

  showImage(String image) {
    return Image.memory(base64Decode(image));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                choiceImage();
              },
              child: Text("chọn hình"),
            ),
            imageData == null
                ? Text("k có hình")
                : Container(
              child: showImage(imageData),
              width: 100,
              height: 100,
            ),
          ],
        ),
    );
  }
}
