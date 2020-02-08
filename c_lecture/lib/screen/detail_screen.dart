import 'package:c_lecture/const.dart';
import 'package:c_lecture/model/lectures.dart';
import 'package:c_lecture/pages/list_page.dart';
import 'package:c_lecture/services/lecture_serivce.dart';
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

    _lectureService.getContents(widget.lecture).then((res) {
      setState(() {
        _markdownData = res;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_markdownData == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    final _scr = PrimaryScrollController.of(context);

    final bottomContentText = SafeArea(
      child: Markdown(
        selectable: true,
        data: _markdownData,
        imageDirectory: Const.LectureServerUrl,
      ),
    );

    final bottomContent = Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(40.0),
        child: bottomContentText);
    /*children: <Widget>[topContent, bottomContent],*/

    return Scaffold(
      body: CustomScrollView(
        controller: _scr,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: true,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.lecture.title),
              background: Image.network(
                  Const.LectureServerUrl + Const.TitleImagePath,
                  fit: BoxFit.cover),
            ),
          ),
          /*SliverFillRemaining(
            child: bottomContent,
          ),*/
          SliverFillRemaining(
            child: Container(
                child: Markdown(
                controller: _scr,
                data: _markdownData)),
          )
        ],
      ),
    );
  }



}