import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:itime/commons/constants.dart';
import 'package:itime/models/Employee.dart';
import 'package:itime/utils/network_util.dart';
import 'package:itime/widgets/drawer_custom.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

/**
 * @author datnq
 * @Date: 24/11/2020
 *
 * Modification Logs
 * DATE   		AUTHOR 		DESCRIPTION
 * ------------------------------------
 * 24/11/2020	DatNQ		  news feed
 */
NetworkUtil _netUtil = new NetworkUtil();

class NewFeeds extends StatefulWidget {
  @override
  _NewFeedsState createState() => _NewFeedsState();
}

class _NewFeedsState extends State<NewFeeds> {
  SharedPreferences references;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List _employee = new List<Employee>();

  @override
  void initState() {
    super.initState();
    _layDuLieuNhanVien();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return new SafeArea(
      child: new Scaffold(
        key: _scaffoldKey,
        drawer: new FutureBuilder(
          future: _layDuLieuNhanVien(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new DrawerCustom(
                employee: new Employee(
                    tenNhanVien: _employee.length > 0
                        ? _employee[0]['ten_nhan_vien'].toString()
                        : '',
                    emailNhanVien: _employee.length > 0
                        ? _employee[0]['email_nhan_vien'].toString()
                        : '',
                    hinhAnhNhanVien: _employee[0]['hinh_anh_nhan_vien'] == ''
                        ? ""
                        : "assets/images/${_employee[0]['hinh_anh_nhan_vien']}"),
              );
            } else {
              return Drawer();
            }
          },
        ),
        appBar: new AppBar(
          // automaticallyImplyLeading: false,
          backgroundColor: new HexColor("CC0000"),
          // elevation: 0.0,
          title: new Text("IZITIME"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () {},
            ),
            new IconButton(
              icon: new Icon(Icons.notifications),
              onPressed: () {
                Navigator.of(context).pushNamed("/notification");
              },
            ),
          ],
        ),
        backgroundColor: new HexColor("F6F6F6"),
        body: new ListView(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Container(
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                height: size.height / 5,
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: new Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new FutureBuilder(
                          future: _layDuLieuNhanVien(),
                          builder: (context, snapshot){
                            if(!snapshot.hasData) {
                              return new Center(
                                child: new CircularProgressIndicator(),
                              );
                            }
                            return new Container(
                              width: 45,
                              height: 45,
                              decoration: new BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  image: new ExactAssetImage(
                                    _employee[0]['hinh_anh_nhan_vien'] == ''
                                        ? ""
                                        : "assets/images/${_employee[0]['hinh_anh_nhan_vien']}",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                        new SizedBox(width: 10),
                        new Container(
                          width: size.width / 1.4,
                          height: size.height / 14,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(50.0),
                            color: Colors.grey[200],
                          ),
                          child: new TextFormField(
                            decoration: new InputDecoration(
                              contentPadding: EdgeInsets.only(left: 20.0),
                              border: InputBorder.none,
                              hintStyle: new TextStyle(
                                color: new HexColor("606266"),
                                fontSize: kTextSize - 3,
                              ),
                              hintText: "Bạn đang nghĩ gì?",
                            ),
                          ),
                        ),
                      ],
                    ),
                    new SizedBox(height: 10.0),
                    new Container(
                      child: new Divider(
                        thickness: 2,
                        color: new HexColor("E4E6EB"),
                      ),
                    ),
                    new SizedBox(height: 10.0),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new Container(
                          child: new Row(
                            children: [
                              new Icon(
                                Icons.lock_open,
                                color: Colors.grey,
                                size: 20,
                              ),
                              new Text(
                                "Phát trực tiếp",
                                style: new TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        new Container(
                          child: new Row(
                            children: [
                              new Icon(
                                Icons.lock_open,
                                color: Colors.grey,
                                size: 20,
                              ),
                              new Text(
                                "Ảnh",
                                style: new TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        new Container(
                          child: new Row(
                            children: [
                              new Icon(
                                Icons.lock_open,
                                color: Colors.grey,
                                size: 20,
                              ),
                              new Text(
                                "Phòng họp",
                                style: new TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      new Text("Stories",
                          style: new TextStyle(
                              fontSize: kTextSize,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold)),
                      new Text("See Archive"),
                    ],
                  ),
                  new SizedBox(height: 20),
                  new Container(
                    height: 180,
                    child: new ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        makeStory(
                            storyImage: "assets/stories/story1.jpg",
                            userImage: "assets/users/user1.jpg",
                            userName: "Hoàng Ngân"),
                        makeStory(
                            storyImage: "assets/stories/story2.jpg",
                            userImage: "assets/users/user2.jpg",
                            userName: "Nguyễn Thảo Phương"),
                        makeStory(
                            storyImage: "assets/stories/story3.jpg",
                            userImage: "assets/users/user3.jpg",
                            userName: "Ny Sun"),
                      ],
                    ),
                  ),
                  new SizedBox(height: 20),
                  makeFeed(
                    userName: "Ny Sun",
                    userImage: "assets/users/user3.jpg",
                    feedTime: "2 giờ",
                    feedText: "Không có tiền😩😩nhưng thứ gì cũng muốn mua🤭🤭",
                    feedImage: "assets/feeds/feed1.jpg",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget makeStory({storyImage, userImage, userName}) {
    return new AspectRatio(
      aspectRatio: 1.6 / 2,
      child: new Container(
        margin: new EdgeInsets.only(
          right: 10,
        ),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(10.0),
          image: new DecorationImage(
            image: new AssetImage(storyImage),
            fit: BoxFit.cover,
          ),
        ),
        child: new Container(
          padding: const EdgeInsets.all(10.0),
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(15.0),
            gradient: new LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(.9),
                Colors.black.withOpacity(.1),
              ],
            ),
          ),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Container(
                width: 40,
                height: 40,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  border: new Border.all(color: Colors.white, width: 2),
                  image: new DecorationImage(
                    image: new AssetImage(userImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              new Text(
                userName,
                style: new TextStyle(
                  color: new HexColor("FFFFFF"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeFeed({userName, userImage, feedTime, feedText, feedImage}) {
    return new Container(
      margin: new EdgeInsets.only(bottom: 20),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Row(
                children: [
                  new Container(
                    width: 50,
                    height: 50,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        image: new AssetImage(userImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  new SizedBox(width: 10),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text(
                        userName,
                        style: new TextStyle(
                            color: Colors.grey[900],
                            fontSize: kTextSize,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                      new Text(
                        feedTime,
                        style: new TextStyle(
                          fontSize: kTextSize - 3,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              new IconButton(
                icon: new Icon(
                  Icons.more_horiz,
                  size: 30,
                  color: Colors.grey[600],
                ),
                onPressed: () {},
              ),
            ],
          ),
          new SizedBox(height: 20),
          new Text(
            feedText,
            style: new TextStyle(
                fontSize: kTextSize - 2,
                color: Colors.grey[700],
                height: 1.5,
                letterSpacing: .7),
          ),
          new SizedBox(height: 20),
          feedImage != ''
              ? new Container(
                  height: 250,
                  decoration: new BoxDecoration(
                    // borderRadius: BorderRadius.circular(10.0),
                    image: new DecorationImage(
                      image: new AssetImage(feedImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : new Container(),
          new SizedBox(height: 20),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Row(
                children: <Widget>[
                  makeLike(),
                  new Transform.translate(
                    offset: new  Offset(-6, 0),
                    child: makeLove(),
                  ),
                  new Text(
                    "2,5k",
                    style: new TextStyle(
                      fontSize: kTextSize - 2,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
              new Text(
                "400 Comments",
                style: new TextStyle(
                  fontSize: kTextSize - 2,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          new SizedBox(height: 10),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              makeLikeButton(isActive: true),
              makeCommentButton(),
              makeShareButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget makeLike() {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white)),
      child: Center(
        child: Icon(Icons.thumb_up, size: 12, color: Colors.white),
      ),
    );
  }

  Widget makeLove() {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white)),
      child: Center(
        child: Icon(Icons.favorite, size: 12, color: Colors.white),
      ),
    );
  }

  Widget makeLikeButton({isActive}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]),
          borderRadius: BorderRadius.circular(50)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.thumb_up,
              color: isActive ? Colors.blue : Colors.grey,
              size: 15,
            ),
            SizedBox(width: 5),
            Text(
              "Like",
              style: TextStyle(
                color: isActive ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget makeCommentButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]),
          borderRadius: BorderRadius.circular(50)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              color: Colors.grey,
              size: 15,
            ),
            SizedBox(width: 5),
            Text(
              "Comments",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget makeShareButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]),
          borderRadius: BorderRadius.circular(50)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.share_sharp,
              color: Colors.grey,
              size: 15,
            ),
            SizedBox(width: 5),
            Text(
              "Shares",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _layDuLieuNhanVien() async {
    references = await SharedPreferences.getInstance();
    Map param = {
      'what': 110,
      'ten_dang_nhap': references.getString('tenDangNhap'),
    };
    final url = BASE_URL_GET + '?input=' + jsonEncode(param);
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    if (mounted) {
      setState(() {
        _employee = json.decode(res.body);
      });
    }
    return "Success";
  }
}