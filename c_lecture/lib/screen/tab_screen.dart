import 'dart:io';


import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:c_lecture/pages/list_page.dart';
import 'package:c_lecture/pages/settings_page.dart';
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

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit an App'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () => exit(0),
            /*Navigator.of(context).pop(true)*/
            child: Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(

          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            children: <Widget>[
              ListPage(title: 'C Language'),
              SettingPage(title: 'Settings'),
            ],
          ),
          bottomNavigationBar:  BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                title: Text('Lecture'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.exit_to_app),
                title: Text('Exit'),
              ),
            ],
            currentIndex: _page,
            selectedItemColor: Colors.white,
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
            onTap: navigationTapped,
          ),


        )
      );
  }

  void navigationTapped(int page) {
    if(page == 1)
      _onWillPop();
    else{
      _controller.jumpToPage(page);
      onPageChanged(page);
    }
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
