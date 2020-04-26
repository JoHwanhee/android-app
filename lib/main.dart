import 'package:c_lecture/providers/lecture_provier.dart';
import 'package:c_lecture/screen/splash_screen.dart';
import 'package:flutter/material.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/TabScreen': (BuildContext context) => new TabScreen(),
      },
    );
  }
}