import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mana/screens/map/map_screen.dart';
import 'package:mana/screens/menu/menu_screen.dart';
import 'package:mana/services/auth_service.dart';
import 'dart:ui';
import 'package:mana/widgets/ui_helper.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.auth, this.logoutCallback}) : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;

  @override
  State<StatefulWidget> createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  GlobalKey bottomNavigationKey = GlobalKey();
  int currentPage = 0;

  FirebaseUser _user;

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      if (user != null) {
        setState(() {
          _user = user;
        });
      }
    });
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return MapScreen();
      case 1:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Fluxo em construção, area para rede social."),
          ],
        );
      case 2:
        return MenuScreen(auth: widget.auth, logoutCallback: widget.logoutCallback,);
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: _getPage(currentPage),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(
              iconData: Icons.map,
              title: "Mapa",),
          TabData(
              iconData: Icons.people,
              title: "Manas",),
          TabData(
            iconData: Icons.menu, 
            title: "Menu",),
        ],
        initialSelection: 0,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
    );
  }
}
