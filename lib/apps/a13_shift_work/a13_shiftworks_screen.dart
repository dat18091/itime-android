import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:itime/apps/a13_shift_work/components/a13_shift_card.dart';
import 'package:itime/apps/a13_shift_work/components/a13_shift_thumbnail.dart';
import 'package:itime/commons/color-pattern.dart';

class ShiftWork extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: HexColor("CC0000"),
        title: Text("Ca làm việc"),
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
      body: ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 24.0,
            ),
            child: Stack(
              children: [
                ShiftCard(),
                ShiftThumbnail(),
              ],
            ),
          );
        },
      ),
    );
  }
}
