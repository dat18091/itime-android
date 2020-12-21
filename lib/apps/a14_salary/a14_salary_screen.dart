import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:itime/commons/color-pattern.dart';
import 'package:itime/commons/constants.dart';

class SalaryScreen extends StatefulWidget {
  @override
  _SalaryScreenState createState() => _SalaryScreenState();
}

class _SalaryScreenState extends State<SalaryScreen> {
  final format = DateFormat("dd-MM-yyyy");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: HexColor("CC0000"),
        title: Text("Chấm công"),
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.black),
                color: HexColor("FFFFFF"),
                borderRadius: BorderRadius.circular(kSizeBorder - 40.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lương tháng 10',
                          style: TextStyle(
                            fontSize: kTextSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '7000000VND',
                          style: TextStyle(
                            fontSize: kTextSize,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Tiền thưởng',
                          style: TextStyle(
                            fontSize: kTextSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '50000VND',
                          style: TextStyle(
                            fontSize: kTextSize,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Tiền phạt',
                          style: TextStyle(
                            fontSize: kTextSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '10000VND',
                          style: TextStyle(
                            fontSize: kTextSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                hintText: 'Xem lương trong tháng',
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
              height: 250.0,
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
                        "Mức lương",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                      new Text(
                        "7000000VND",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text(
                        "Số ngày nghỉ",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                      new Text(
                        "0",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text(
                        "Công trong tháng",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                      new Text(
                        "0",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text(
                        "Số giờ đã làm",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                      new Text(
                        "0",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text(
                        "Số giờ làm còn thiếu",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                      new Text(
                        "0",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text(
                        "Lương tạm tính đến ngày 30/10/2020",
                        style: TextStyle(
                          fontSize: kTextSize - 4,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              height: 150.0,
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
                        "Tiển thưởng",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                      new Text(
                        "1000000VND",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text(
                        "Tiền phạt",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                      new Text(
                        "0",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text(
                        "Lương chính thức",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                      new Text(
                        "7000000",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text(
                        "Lương thực trả",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                      new Text(
                        "7500000",
                        style: TextStyle(fontSize: kTextSize),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
