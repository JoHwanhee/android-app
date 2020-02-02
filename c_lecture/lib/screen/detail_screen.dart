import 'package:c_lecture/const.dart';
import 'package:c_lecture/model/lectures.dart';
import 'package:c_lecture/pages/list_page.dart';
import 'package:c_lecture/services/lecture_serivce.dart';
import 'package:flutter/material.dart';

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
        final bottomContentText = Text(
            _markdownData,
            style: TextStyle(fontSize: 18.0),
        );

        final readButton = Container(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
                onPressed: () => {},
                color: Color.fromRGBO(58, 66, 86, 1.0),
                child:
                Text("TAKE THIS LESSON", style: TextStyle(color: Colors.white)),
            ));
        final bottomContent = Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(40.0),
            child: Center(
                child: Column(
                    children: <Widget>[bottomContentText, readButton],
                ),
            ),
        );
        /*children: <Widget>[topContent, bottomContent],*/
        return Scaffold(
            body: CustomScrollView(

                slivers: <Widget>[
                    SliverAppBar(
                        expandedHeight: 200.0,
                        floating: false,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                            title: Text(widget.lecture.title),
                            background: Image.network(Const.LectureServerUrl + Const.TitleImagePath,
                                fit: BoxFit.cover
                            ),

                        ),
                    ),
                    SliverFillRemaining(
                        child: bottomContent,
                    )

                ],

            ),
        );
    }
}
