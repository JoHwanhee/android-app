import 'dart:io';


import 'package:admob_flutter/admob_flutter.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:c_lecture/pages/list_page.dart';
import 'package:c_lecture/pages/settings_page.dart';
import 'package:flutter/material.dart';

import '../main.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);


  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  final scaffoldKey = GlobalKey<ScaffoldState>();

  AdmobBannerSize bannerSize = AdmobBannerSize.BANNER;


  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titlePadding:
        const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        title: Container(child: Text("Do you want to leave?")),
        contentPadding: const EdgeInsets.all(0),
        content: Container(
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(color: Colors.white),
          child: AdmobManager.finishBanner,
        ),
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



  _defaultWillPop() async {
    var result = await showDialog(
      context: scaffoldKey.currentContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding:
          const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          title: Container(child: Text("Do you want to leave?")),
          contentPadding: const EdgeInsets.all(0),
          content: Container(
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(color: Colors.white),
            child: AdmobManager.finishBanner,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("CANCEL"),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );

    return result;
  }



  @override
  Widget build(BuildContext context) {
    final double paddingBottom = 0;

    return
      WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: Padding(
            padding: new EdgeInsets.only(bottom: paddingBottom),
            child:  PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _controller,
              children: <Widget>[
                ListPage(title: 'C Language'),
                SettingPage(title: 'Settings'),
              ],
            ),
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

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
