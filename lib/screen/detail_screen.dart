import 'package:c_lecture/const.dart';
import 'package:c_lecture/model/lectures.dart';
import 'package:c_lecture/services/lecture_serivce.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class DetailPage extends StatefulWidget {
  final Lecture lecture;

  DetailPage({Key key, this.lecture}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  LectureService _lectureService = LectureService();
  String _markdownData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Const.AdCount < 1){
      FacebookInterstitialAd.loadInterstitialAd(
        placementId: "610582579805224_610601026470046",
        listener: (result, value) {
          if (result == InterstitialAdResult.LOADED){
            FacebookInterstitialAd.showInterstitialAd();
            Const.AdCount ++;
          }

        },
      );
    }
    else if(Const.AdCount > 4){
      Const.AdCount = 0;
    }
    else{
      Const.AdCount ++;
    }

    _lectureService.getContents(widget.lecture).then((res) {
      setState(() {
        _markdownData = res;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text(widget.lecture.title),
    );

    if (_markdownData == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    final _scr = PrimaryScrollController.of(context);


    return Scaffold(
      appBar: topAppBar,
      body: Container(
          child: Markdown(
              controller: _scr,
              data: _markdownData,
              imageDirectory: Const.ImageServerDirectory,
          )),

    );
  }
}