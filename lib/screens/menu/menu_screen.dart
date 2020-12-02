import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mana/services/auth_service.dart';
import 'package:mana/widgets/ui_helper.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({Key key, this.auth, this.logoutCallback}) : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;

  @override
  _MenuScreenState createState() => new _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
@override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.purple[800],
      body: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(50, 30, 20, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text(
                              'Menu',
                              style: TextStyle(
                                color: Colors.purple[800],
                                fontFamily: "Poppins-Bold",
                                fontSize: ScreenUtil.getInstance().setSp(24),
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 5,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 5,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    width: 20,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFCCD0D7),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: 20,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFCCD0D7),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(50, 0, 20, 30),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '48 projects',
                        style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: ScreenUtil.getInstance().setSp(16),
                          color: Color(0xFFCCD0D7),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(40, 0, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(50, 10, 20, 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'About',
                        style:
                            TextStyle(fontSize: 24, fontFamily: "Poppins-Medium"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(50, 10, 20, 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Studio Booth is a creative house with a\nfocus in illustration and logo design.\nMy philosophy is to create bold\nillustrations an+d strong brands that\ncommunicate well and are o++',
                        style: TextStyle(fontSize: 16, fontFamily: "Poppins-Medium"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}