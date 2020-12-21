import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:itime/commons/constants.dart';

class ShiftCard extends StatefulWidget {
  @override
  _ShiftCardState createState() => _ShiftCardState();
}

class _ShiftCardState extends State<ShiftCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 124.0,
      margin: EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: new HexColor("FFFFFF"),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "Ca hành chính",
                  style: TextStyle(
                    fontSize: kTextSize + 3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      "08:00",
                      style: TextStyle(
                        fontSize: kTextSize - 1,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      "17:00",
                      style: TextStyle(
                        fontSize: kTextSize - 1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
