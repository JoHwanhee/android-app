import 'dart:async';

import 'package:c_lecture/screen/tab_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
    @override
    _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    startTime() async {
        var _duration = new Duration(seconds: 2);
        return Timer(_duration, navigationPage);
    }

    void navigationPage() {
        Navigator.of(context).pushReplacementNamed(TabScreen.tag);
    }

    @override
    void initState() {
        super.initState();
        startTime();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Center(
                child: Image.asset('assets/images/flutterwithlogo.png'),
            ),
        );
    }
}