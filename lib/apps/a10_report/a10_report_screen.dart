import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:itime/commons/constants.dart';

class ReportSummary extends StatefulWidget {
  @override
  _ReportSummaryState createState() => _ReportSummaryState();
}

class _ReportSummaryState extends State<ReportSummary> {
  final format = DateFormat("dd-MM-yyyy");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("FFFFFF"),
      appBar: AppBar(
        backgroundColor: HexColor("CC0000"),
        title: Text("Báo cáo"),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: new Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          // Text('Basic date & time field (${format.pattern})'),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
            child: DateTimeField(
              style: new TextStyle(
                fontSize: kTextSize,
                color: HexColor('4D5156'),
              ),
              cursorColor: new HexColor('4D5156'),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
                prefixIcon: new Icon(
                  Icons.content_paste_rounded,
                  color: new HexColor('4D5156'),
                ),
                hintText: 'Chọn ngày báo cáo',
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(kSizeBorder),
                  borderSide: new BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kSizeBorder),
                  borderSide: BorderSide(
                    color: HexColor("4696EC"),
                    width: 2.0,
                  ),
                ),
              ),
              format: format,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              height: 300.0,
              decoration: BoxDecoration(
                color: HexColor("FFFFFF"),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text(
                        "Số giờ đi trễ",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                      new Text(
                        "0",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                    ],
                  ),
                  Divider(color: Colors.black),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text(
                        "Số giờ về sớm",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                      new Text(
                        "0",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                    ],
                  ),
                  Divider(color: Colors.black),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text(
                        "Số ca xin nghỉ không phép",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                      new Text(
                        "0",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                    ],
                  ),
                  Divider(color: Colors.black),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text(
                        "Số ca xin nghỉ có phép",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                      new Text(
                        "0",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                    ],
                  ),
                  Divider(color: Colors.black),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text(
                        "Tổng số giờ làm thực tế",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                      new Text(
                        "0",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                    ],
                  ),
                  Divider(color: Colors.black),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text(
                        "Tổng số công",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                      new Text(
                        "0",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
