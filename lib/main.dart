import 'package:c_lecture/providers/lecture_provier.dart';
import 'package:c_lecture/screen/login_screen.dart';
import 'package:c_lecture/screen/splash_screen.dart';
import 'package:c_lecture/util/MyBehavior.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'screen/tab_screen.dart';



void main() {
  runApp(
    MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => LectureProvider())],
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: 'NotoSans'
      ),
      home: SplashScreen(),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      routes: <String, WidgetBuilder>{
        '/TabScreen': (BuildContext context) => new TabScreen(),
      },
    );
  }
}