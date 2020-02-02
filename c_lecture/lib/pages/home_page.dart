import 'package:c_lecture/design_course_app_theme.dart';
import 'package:c_lecture/model/lectures.dart';
import 'package:c_lecture/providers/lecture_provier.dart';
import 'package:c_lecture/services/lecture_serivce.dart';
import 'package:c_lecture/util/util.dart';
import 'package:c_lecture/view/popular_course_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Lectures _lectures;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    LectureService().getLectures().then((res) {
      setState(() {
        _lectures = res;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('C Language'),),

      backgroundColor: Colors.transparent,
      body:getPopularCourseUI(),
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, left: 18, right: 18),
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

        ],
      ),
    );
  }

  Widget getPopularCourseUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Flexible(
            child: _lectures == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : PopularCourseListView(lectures: _lectures),
          )
        ],
      ),
    );
  }


}

enum CategoryType {
  ui,
  coding,
  basic,
}
