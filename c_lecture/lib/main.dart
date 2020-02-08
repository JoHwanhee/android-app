import 'package:c_lecture/pages/list_page.dart';
import 'package:c_lecture/providers/lecture_provier.dart';

import 'package:c_lecture/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_admob/firebase_admob.dart';

final String _appId = 'ca-app-pub-7900199678363792~2460237454';
final String _bannerUnitId = 'ca-app-pub-3940256099942544/6300978111';

void main() {
  runApp(
    MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => LectureProvider())],
        child: MyApp()),
  );

  FirebaseAdMob.instance.initialize(appId: _appId);
}

BannerAd banner = BannerAd(
  adUnitId: _bannerUnitId,
  size: AdSize.fullBanner,
  listener: (MobileAdEvent event) {
    print("$event");
  },
);

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['flutterio', 'beautiful apps'],
  contentUrl: 'https://flutter.dev',
  childDirected: false,
  testDevices: <String>[],
);

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
        '/TabScreen': (BuildContext context) => new ListPage(
              title: 'C Language',
            ),
      },
    );
  }
}
