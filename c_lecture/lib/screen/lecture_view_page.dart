import 'package:c_lecture/design_course_app_theme.dart';
import 'package:c_lecture/model/lectures.dart';
import 'package:c_lecture/services/lecture_serivce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class LectureViewPage extends StatefulWidget {
  Lecture _lecture;

  LectureViewPage(Lecture lecture)
  {
    _lecture = lecture;
  }

  @override
  _LectureViewPageState createState() => _LectureViewPageState();
}

class _LectureViewPageState extends State<LectureViewPage> {
  LectureService _lectureService = LectureService();
  String _markdownData;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    _lectureService.getContents(widget._lecture).then((res) {
      setState(() {
        _markdownData = res;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignCourseAppTheme.nearlyWhite,
        iconTheme: IconThemeData.fallback(),
        title: Text('a'),
        
      ),
      body: _buildBody(),
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '둥둥\'s',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: DesignCourseAppTheme.grey,
                  ),
                ),
                Text(
                  '프로그래밍 강의 플랫폼',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color: DesignCourseAppTheme.darkerText,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 60,
            height: 60,
            child: Image.asset('assets/design_course/userImage.png'),
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    final controller = ScrollController();

    if(_markdownData == null ){

      return Center(
          child: Container(
              child: CircularProgressIndicator(),
          ),
      );
    }

    return SafeArea(
      child: Markdown(
        controller: controller,
        selectable: true,
        data: _markdownData,
        imageDirectory: 'https://raw.githubusercontent.com',
      ),
    );
  }
}
