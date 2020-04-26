
import 'package:c_lecture/model/lectures.dart';
import 'package:c_lecture/screen/detail_screen.dart';
import 'package:c_lecture/services/lecture_serivce.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
    ListPage({Key key, this.title}) : super(key: key);

    final String title;

    @override
    _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
    Lectures _lectures;

    @override
    void initState() {
        super.initState();

        LectureService().getLectures().then((res) {
            setState(() {
                _lectures = res;
            });
        });
    }

    @override
    Widget build(BuildContext context)
    {
        if( _lectures == null )
            return Container(
                color: Color.fromRGBO(58, 66, 86, 1.0),
                    child: Center(
                        child: CircularProgressIndicator()
                )
            );

        ListTile makeListTile(Lecture lecture) => ListTile(
            contentPadding:
            EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),

            title: Text(
                lecture.title,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

            subtitle: Row(
                children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Container(
                            // tag: 'hero',
                            child: LinearProgressIndicator(
                                backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                                value: lecture.indicatorValue,
                                valueColor: AlwaysStoppedAnimation(Colors.green)),
                        )),
                    Expanded(
                        flex: 4,
                        child: Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(lecture.level,
                                style: TextStyle(color: Colors.white))),
                    )
                ],
            ),
            trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
            onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(lecture: lecture)));
            },
        );

        Card makeCard(Lecture lesson) => Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
                decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                child: makeListTile(lesson),
            ),
        );

        final makeBody = Container(
            // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _lectures.data.length,
                itemBuilder: (BuildContext context, int index) {
                    return makeCard(_lectures.data[index]);

                },
            ),
        );


        final topAppBar = AppBar(
            elevation: 0.1,
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
            title: Text(widget.title),
        );

        return Scaffold(
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
            appBar: topAppBar,
            body: makeBody,

        );
    }
}
