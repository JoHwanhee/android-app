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
  final String id;

  FeedPage({Key key, this.title, this.feed, this.id}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  Feed feed;
  final TextEditingController _textController = new TextEditingController();
  FeedService feedService = FeedService();
  @override
  void initState() {
    super.initState();

      if(widget.feed == null ){
        feedService.getFeed(widget.id).then((res) {
          setState(() {
            feed = res;
          });
        });
      }
      else {
        setState(() {
          feed = widget.feed;
        });
      }
  }
  @override
  void dispose(){
    _textController.dispose();
    super.dispose();
  }

  Widget _buildTextField(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
      child: TextField(
        controller: _textController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onSubmitted: _handleSubmitted,
        cursorColor: Colors.white,

        style: new TextStyle(color: Colors.white),
        decoration: new InputDecoration.collapsed(hintText: "댓글쓰기",

          hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),

        ),
      ),
    );
  }


  Widget _buildTextComposer() {
    return Column(
      children: <Widget>[
        Container(color: Colors.white10, height: 1,),
        Row(children: <Widget>[
          Flexible(child: _buildTextField()),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 0.0),
            child: IconButton(icon: Icon(Icons.send, color: Colors.white,),
                onPressed: () => _handleSubmitted(_textController.text)),),
          ]),
      ],
    );
  }



  void _handleSubmitted(String text) {
    if (text == null) return;
    if (text.isEmpty) return;

    DeviceUtil.getId(context).then((res) {
      var json = {
        'user_id': res,
        'content': _textController.text,
        'created': DateTimeUtils.getUtcString()
      };
      feedService.postReply(feed.id, jsonEncode(json));

      setState(() {
        feed.replies.add(Replies.fromJson(json));
      });

      _textController.clear();
    });

  }

  Widget _buildMainContents(){
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          padding: EdgeInsets.only(
              left: 10, right: 10, top: 10, bottom: 10),
          child: Text(feed.content,
            style: TextStyle(color: Colors.white, fontSize: 16),),
        ),
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15.0, bottom: 10, top: 3),
              child: Icon(
                Icons.question_answer, color: Colors.white, size: 15,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0, bottom: 10, top: 3),
              child: Text(feed.replies.length.toString(),
                style: TextStyle(color: Colors.white),),
            ),
            Expanded(
              flex: 0,
              child: Padding(
                  padding: EdgeInsets.only(left: 15.0, bottom: 10, top: 3),
                  child: Text(feed.isAdmin ? "관리자" : feed.userId,
                      style: TextStyle(color: Colors.grey))),
            ),
            Expanded(
              flex: 0,
              child: Padding(
                  padding: EdgeInsets.only(left: 5.0, bottom: 8, top: 3),
                  child: Text(
                      DateTimeUtils.utcStringToLocalString(feed.created),
                      style: TextStyle(color: Colors.grey))),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildReplies(){
    return Expanded(
        flex: 1,
        child: RefreshIndicator(
          onRefresh: _getData,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(8.0),
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: false,
            itemCount: feed.replies.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if(index == 0){
                return Column(
                  children: <Widget>[
                    _buildMainContents(),
                    Container(
                      height: 2,
                      color: Colors.white10,
                    ),
                    feed.replies.length != 0 ? makeContents(index) : Container()
                  ],

                );
              }

              if(index >= feed.replies.length){
                return Container();
              }

              return makeContents(index);
            },),
        ));
  }

  @override
  void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }

  ListTile makeContents(index) =>
      ListTile(
        dense: true,
        contentPadding: EdgeInsets.only(left: 15, right: 16),
        title: Text(
          feed.replies[index].content,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

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
                  child: Text(DateTimeUtils.utcStringToLocalString(
                      feed.replies[index].created),
                      style: TextStyle(color: Colors.grey))),
            )
          ],
        ),
      );


  @override
  Widget build(BuildContext context) {
    if(feed == null){
      return Container(
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Center(child: CircularProgressIndicator()));
    }

    final makeBody = Column(
      children: [
        _buildReplies(),
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
    var result = await feedService.getFeed(feed.id);
    setState(() {
      feed = result;
    });
  }


  void fetchReplies() async {
    var result = await feedService.getFeed(feed.id);
    setState(() {
      feed = result;
    });
  }
}
