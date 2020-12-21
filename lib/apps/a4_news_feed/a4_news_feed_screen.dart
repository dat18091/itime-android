import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:itime/commons/constants.dart';
import 'package:itime/models/Employee.dart';
import 'package:itime/services/data_services.dart';
import 'package:itime/widgets/drawer_custom.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
 * @author datnq
 * @Date: 24/11/2020
 *
 * Modification Logs
 * DATE   		AUTHOR 		DESCRIPTION
 * ------------------------------------
 * 24/11/2020	DatNQ		  news feed
 */
DataServices _dataServices = new DataServices();

class NewFeeds extends StatefulWidget {
  @override
  _NewFeedsState createState() => _NewFeedsState();
}

class _NewFeedsState extends State<NewFeeds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      drawer: new DrawerCustom(),
      appBar: new AppBar(
         automaticallyImplyLeading: false,
        backgroundColor: new HexColor("CC0000"),
        // elevation: 0.0,
        title: Row(
          children: [
            new Image.asset(
              'assets/icons/logo-itime96x96.png',
              width: 30,
              height: 30,
            ),
            new SizedBox(
              width: 5,
            ),
            new Text("IZITIME"),
          ],
        ),
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
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              // color: Colors.white,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(
                  top: 5.0, right: 10, left: 10, bottom: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: Colors.grey[200],
                      ),
                      child: TextField(
                        decoration: new InputDecoration(
                          prefixIcon:
                          new Icon(Icons.search, color: Colors.grey),
                          border: InputBorder.none,
                          hintStyle: new TextStyle(color: Colors.grey),
                          hintText: "Search",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Icon(Icons.camera_alt, color: Colors.grey[800], size: 30)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              // color: Colors.white,
              width: double.infinity,
              height: 130,
              decoration: BoxDecoration(
                // border: new OutlineInputBorder(
                //   borderRadius: const BorderRadius.all(
                //     const Radius.circular(30.0),
                //   ),
                // ),
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.orange, shape: BoxShape.circle),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 260,
                        height: 45,
                        // color: Hexcolor("E9EAEF"),
                        child: new TextField(
                          decoration: new InputDecoration(
                            // border: new OutlineInputBorder(
                            //   borderRadius: const BorderRadius.all(
                            //     const Radius.circular(30.0),
                            //   ),
                            // ),
                            // filled: true,
                              hintStyle: new TextStyle(color: Colors.grey[800]),
                              hintText: "Bạn đang nghĩ gì?",
                              fillColor: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // width: 280,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.lock_open,
                              color: Colors.grey,
                              size: 20,
                            ),
                            // SizedBox(width: 10),
                            Text(
                              "Phát trực tiếp",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // width: 280,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.lock_open,
                              color: Colors.grey,
                              size: 20,
                            ),
                            // SizedBox(width: 10),
                            Text(
                              "Ảnh",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // width: 280,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.lock_open,
                              color: Colors.grey,
                              size: 20,
                            ),
                            // SizedBox(width: 10),
                            Text(
                              "Phòng họp",
                              style: TextStyle(fontSize: 15),
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text("Stories",
                        style: TextStyle(
                            fontSize: kTextSize,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold)),
                    Text("See Archive"),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 180,
                  child: ListView(
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
                SizedBox(height: 20),
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
    );
  }

  Widget makeStory({storyImage, userImage, userName}) {
    return AspectRatio(
      aspectRatio: 1.6 / 2,
      child: Container(
        margin: EdgeInsets.only(
          right: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: new DecorationImage(
            image: new AssetImage(storyImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(.9),
                Colors.black.withOpacity(.1),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  image: DecorationImage(
                    image: AssetImage(userImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                userName,
                style: TextStyle(
                  color: HexColor("FFFFFF"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeFeed({userName, userImage, feedTime, feedText, feedImage}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        image: AssetImage(userImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: kTextSize,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                      Text(
                        feedTime,
                        style: TextStyle(
                          fontSize: kTextSize - 3,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.more_horiz,
                  size: 30,
                  color: Colors.grey[600],
                ),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            feedText,
            style: TextStyle(
                fontSize: kTextSize - 2,
                color: Colors.grey[700],
                height: 1.5,
                letterSpacing: .7),
          ),
          SizedBox(height: 20),
          feedImage != ''
              ? Container(
            height: 250,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage(feedImage),
                fit: BoxFit.cover,
              ),
            ),
          )
              : Container(),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: <Widget>[
                  makeLike(),
                  Transform.translate(
                    offset: Offset(-6, 0),
                    child: makeLove(),
                  ),
                  Text(
                    "2,5k",
                    style: TextStyle(
                      fontSize: kTextSize - 2,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
              Text(
                "400 Comments",
                style: TextStyle(
                  fontSize: kTextSize - 2,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
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
}
