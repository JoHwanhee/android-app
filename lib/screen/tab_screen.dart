import 'dart:convert';
import 'dart:io';


import 'package:c_lecture/pages/feed_page.dart';
import 'package:c_lecture/pages/feeds_page.dart';
import 'package:c_lecture/pages/list_page.dart';
import 'package:c_lecture/pages/settings_page.dart';
import 'package:c_lecture/services/feed_service.dart';
import 'package:c_lecture/services/reg_service.dart';
import 'package:c_lecture/util/util.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:in_app_update/in_app_update.dart';

import '../main.dart';

final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

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

  void checkUpdate() async {
    try
    {
      var info = await InAppUpdate.checkForUpdate();
      if(info.updateAvailable){
        InAppUpdate.startFlexibleUpdate();
      }
    } on Exception catch (_) {

    }
  }

  void initFacebook() async {
    try
    {
      FacebookAudienceNetwork.init();

    } on Exception catch (_) {

    }
  }
  @override
  void initState() {
    checkUpdate();
    initFacebook();

    super.initState();
    firebaseCloudMessaging_Listeners();
    _controller = PageController(initialPage: 0);
  }

  void iOS_Permission() {
    firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings)
    {
      print("Settings registered: $settings");
    });
  }

  void movePage(message) async {
    var feed = await FeedService().getFeed(message['data']['id']);

    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FeedPage( title: 'Feed', feed: feed,)),
      );
    });
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    firebaseMessaging.getToken().then((token){
      DeviceUtil.getId(context).then((id) {
        RegService().postDevice(jsonEncode({"user_id" : id, "device_id": token}));
        print('token:'+token);
      });
    });

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        //movePage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        movePage(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        movePage(message);
      },
    );
  }



  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  final scaffoldKey = GlobalKey<ScaffoldState>();


  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titlePadding:
        const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        title: Container(child: Text("종료 하시겠습니까?")),
        contentPadding: const EdgeInsets.all(0),

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
                FeedsPage(title: 'Feeds'),
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
                icon: Icon(Icons.question_answer),
                title: Text('Feeds'),
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
    if(page == 2)
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
