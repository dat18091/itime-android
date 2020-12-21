import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:itime/commons/constants.dart';

class RewardScreen extends StatefulWidget {
  @override
  _RewardScreenState createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("F8F8F8"),
      appBar: AppBar(
        backgroundColor: HexColor("CC0000"),
        title: Text("Đổi thưởng"),
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
              // margin: EdgeInsets.symmetric(horizontal: 31, vertical: 21),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5.0,
                      color: Colors.red[200],
                      offset: Offset(0, 5)),
                ],
                borderRadius: BorderRadius.circular(15.0),
                gradient: LinearGradient(
                  colors: [
                    Color(0xffff8964),
                    Color(0xffff5d6e),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Nguyễn Quang Đạt",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: kTextSize + 3,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tổng số coin (ICN):',
                          style: TextStyle(
                            fontSize: kTextSize,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '20 ICN',
                          style: TextStyle(
                            fontSize: kTextSize,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Số tài khoản:',
                          style: TextStyle(
                            fontSize: kTextSize,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '560254',
                          style: TextStyle(
                            fontSize: kTextSize,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tên tài khoản:',
                          style: TextStyle(
                            fontSize: kTextSize,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'NGUYEN QUANG DAT',
                          style: TextStyle(
                            fontSize: kTextSize - 3,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tên ngân hàng:',
                          style: TextStyle(
                            fontSize: kTextSize,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'TP BANK',
                          style: TextStyle(
                            fontSize: kTextSize,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '1INC (IZICOINS) = 5000VND',
                      style: TextStyle(
                        fontSize: kTextSize - 4,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Danh mục chuyển tiền',
              style: TextStyle(
                fontSize: kTextSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              height: 100.0,
              color: Colors.white,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    // height: 50,
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.black),
                    // ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        Image.asset('assets/icons/transaction.png',
                            width: 50, height: 50),
                        Text('Chuyển tiền'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Lịch sử giao dịch',
              style: TextStyle(
                fontSize: kTextSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              height: 200.0,
              color: Colors.white,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Container(
                    child: index % 2 == 0
                        ? ListTile(
                      tileColor: HexColor("B2EBF2"),
                      title: Text(
                        "Nguyễn Quang Đạt",
                        style: TextStyle(
                          fontSize: kTextSize - 3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text("Đã rút 40tr đồng"),
                      trailing: Text("2000ICN"),
                      leading: CircleAvatar(
                          radius: 25,
                          child: Image.asset(
                            'assets/icons/rewardlead.png',
                            height: 50,
                            width: 50,
                          ),
                          backgroundColor: Colors.transparent),
                      enabled: true,
                      onTap: () {},
                    )
                        : ListTile(
                      tileColor: HexColor("D1C4E9"),
                      title: Text(
                        "Nguyễn Quang Đạt",
                        style: TextStyle(
                          fontSize: kTextSize - 3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text("Đã rút 40tr đồng"),
                      trailing: Text("2000ICN"),
                      leading: CircleAvatar(
                          radius: 25,
                          child: Image.asset(
                            'assets/icons/rewardlead.png',
                            height: 50,
                            width: 50,
                          ),
                          backgroundColor: Colors.transparent),
                      enabled: true,
                      onTap: () {},
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
