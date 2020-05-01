import 'dart:convert';

import 'package:c_lecture/model/feeds.dart';
import 'package:c_lecture/model/lectures.dart';
import 'package:c_lecture/screen/detail_screen.dart';
import 'package:c_lecture/services/feed_service.dart';
import 'package:c_lecture/services/lecture_serivce.dart';
import 'package:c_lecture/util/util.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';
import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class FeedPage extends StatefulWidget {
  final Feed feed;
  final String title;

  FeedPage({Key key, this.title, this.feed}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  Feed feed;
  final TextEditingController _textController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      feed = widget.feed;
    });

  }

  /// Loads the document to be edited in Zefyr.
  NotusDocument _loadDocument() {
    // For simplicity we hardcode a simple document with one line of text
    // saying "Zefyr Quick Start".
    // (Note that delta must always end with newline.)
    final Delta delta = Delta()..insert("Zefyr Quick Start\n");
    return NotusDocument.fromDelta(delta);
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        controller: _textController,
        onSubmitted: _handleSubmitted,
        cursorColor: Colors.white,
        autofocus: true,
        style: new TextStyle(color: Colors.white),
        decoration: new InputDecoration.collapsed(hintText: "Write a message", hintStyle: TextStyle(fontSize: 14.0, color: Colors.blueGrey),

        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    var json = { 'user_id' : feed.userId, 'content' : _textController.text, 'created': DateTimeUtils.getUtcString()};
    FeedService().postReply(feed.id, jsonEncode(json));

    setState(() {
      feed.replies.add(Replies.fromJson(json));
    });

    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    /*       if( _lectures == null )
            return Container(
                color: Color.fromRGBO(58, 66, 86, 1.0),
                    child: Center(
                        child: CircularProgressIndicator()
                )
            );*/

    ListTile makeContents(index) => ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(left: 15, right: 16),
          title: Text(
            feed.replies[index].content,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Row(
            children: <Widget>[
              Expanded(
                flex: 0,
                child: Padding(
                    padding: EdgeInsets.only(left: 0.0, bottom: 0, top: 3),
                    child: Text(feed.replies[index].userId,
                        style: TextStyle(color: Colors.grey))),
              ),
              Expanded(
                flex: 0,
                child: Padding(
                    padding: EdgeInsets.only(left: 5.0, bottom: 0, top: 3),
                    child: Text(DateTimeUtils.utcStringToLocalString(feed.replies[index].created),
                        style: TextStyle(color: Colors.grey))),
              )
            ],
          ),
        );

    final makeBody = Column(
      children: [

        Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              child: Text(feed.content, style: TextStyle(color: Colors.white, fontSize: 16),),
            ),
            Row(

              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 15.0, bottom: 10, top: 3),
                  child: Icon(Icons.question_answer, color: Colors.white,size: 15,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15.0, bottom: 10, top: 3),
                  child: Text(feed.replies.length.toString(), style: TextStyle(color: Colors.white),),
                ),
                Expanded(
                  flex: 0,
                  child: Padding(
                      padding: EdgeInsets.only(left: 15.0, bottom: 10, top: 3),
                      child: Text(feed.isAdmin ? "관리자": feed.userId,
                          style: TextStyle(color: Colors.grey))),
                ),
                Expanded(
                  flex: 0,
                  child: Padding(
                      padding: EdgeInsets.only(left: 5.0, bottom: 8, top: 3),
                      child: Text(DateTimeUtils.utcStringToLocalString(feed.created),
                          style: TextStyle(color: Colors.grey))),
                )
              ],
            ),
          ],
        ),
        Container(
          height: 4,
          color: Colors.white10,
        ),
        Expanded(
        child:  RefreshIndicator(
          onRefresh: _getData,
          child: ListView.builder(
          scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: feed.replies.length,
            itemBuilder: (BuildContext context, int index) {
              return makeContents(index);
            },),
        )),
        _buildTextComposer()
      ],


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

  Future<void> _getData() async {
    setState(() {
      fetchReplies();
    });
  }


  void fetchReplies() async {
    var result = await FeedService().getFeed(feed.id);
    setState(() {
      feed = result;
    });
  }


}
