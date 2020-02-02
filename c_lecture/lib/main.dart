import 'package:c_lecture/pages/list_page.dart';
import 'package:c_lecture/providers/app_provider.dart';
import 'package:c_lecture/providers/lecture_provier.dart';
import 'package:c_lecture/pages/home_page.dart';
import 'package:c_lecture/screen/splash_screen.dart';
import 'package:c_lecture/screen/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LectureProvider()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: MyApp()
  ),);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/TabScreen': (BuildContext context) => new ListPage(title: 'C Language',)
      },
    );
  }
}
