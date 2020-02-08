import 'dart:io';


import 'package:c_lecture/pages/list_page.dart';
import 'package:c_lecture/pages/profile_page.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  static String tag = "/TabScreen";

  @override
  _TabScreenState createState() => new _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
          children: <Widget>[
            ListPage(title: 'C Language',),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: FancyBottomNavigation(
          circleColor: Colors.blue,
          inactiveIconColor: Colors.blue,
          initialSelection: 0,
          barBackgroundColor: Colors.white70,
          tabs: [
            TabData(iconData: Icons.home, title: "Home"),
            TabData(iconData: Icons.settings, title: "Settings")
          ],
          onTabChangedListener: (position) {
            setState(() {
              _page = position;
              navigationTapped(_page);
            });
          },

        ));
  }

  final makeBottom = Container(
    height: 55.0,
    child: BottomAppBar(
      color: Color.fromRGBO(58, 66, 86, 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.blur_on, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.hotel, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_box, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
    ),
  );

  void navigationTapped(int page) {
    _controller.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
