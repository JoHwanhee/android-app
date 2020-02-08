import 'package:admob_flutter/admob_flutter.dart';
import 'package:c_lecture/pages/list_page.dart';
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

//  FirebaseAdMob.instance.initialize(appId: _appId);

}

/*BannerAd banner = BannerAd(
  adUnitId: _bannerUnitId,
  size: AdSize.smartBanner,
  listener: (MobileAdEvent event) {
    print("$event");
  },
);

BannerAd exitBanner = BannerAd(
  adUnitId: _bannerUnitId,
  size: AdSize.mediumRectangle,
  listener: (MobileAdEvent event) {
    print("$event");
  },
);

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['flutterio', 'beautiful apps'],
  contentUrl: 'https://flutter.dev',
  childDirected: false,
  testDevices: <String>[],
);*/

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


class AdmobManager {
  static bool _isTest = true;

  static String test_app_id = 'ca-app-pub-7900199678363792~2460237454';
  static String test_banner_id = 'ca-app-pub-3940256099942544/6300978111';

  static String app_id = "ca-app-pub-7900199678363792~2460237454";
  static String banner_id = "ca-app-pub-7900199678363792/2995918918 ";

  static Admob initAdMob() {
    print("initAdMob");
    return Admob.initialize(_isTest ? test_app_id : app_id);
  }

  static AdmobBanner bottomBanner = AdmobBanner(
    adUnitId: _isTest ? test_banner_id : banner_id,
    adSize: AdmobBannerSize.BANNER,
  );

  static AdmobBanner finishBanner = AdmobBanner(
    adUnitId: _isTest ? test_banner_id : banner_id,
    adSize: AdmobBannerSize.MEDIUM_RECTANGLE,
  );
}