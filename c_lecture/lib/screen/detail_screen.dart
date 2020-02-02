import 'package:c_lecture/pages/list_page.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
    final Lesson lesson;
    DetailPage({Key key, this.lesson}) : super(key: key);
    @override
    Widget build(BuildContext context) {
        final bottomContentText = Text(
            lesson.content,
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
                            title: Text(lesson.title),
                            background: Image.network('https://mblogthumb-phinf.pstatic.net/MjAxODA1MDVfMTQg/MDAxNTI1NTMyMDE0OTAy.Y2Kks89wfLEb0RE5asO0NoH6an6cJH0OT92jeeZK6pgg.CQYa8UNPGHk2hW5BAy2V8toWQ2lKCEs7TzHZrikX8gIg.JPEG.comeinto_/output_2405482813.jpg?type=w800',
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