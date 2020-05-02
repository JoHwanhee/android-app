import 'dart:convert';

import 'package:c_lecture/const.dart';
import 'package:c_lecture/model/feeds.dart';
import 'package:c_lecture/model/lectures.dart';
import 'package:c_lecture/pages/feed_page.dart';
import 'package:c_lecture/screen/detail_screen.dart';
import 'package:c_lecture/screen/write_feed_screen.dart';
import 'package:c_lecture/services/feed_service.dart';
import 'package:c_lecture/services/lecture_serivce.dart';
import 'package:c_lecture/util/util.dart';
import 'package:device_info/device_info.dart';
import 'package:facebook_audience_network/ad/ad_instream.dart';
import 'package:facebook_audience_network/ad/ad_native.dart';
import 'package:flutter/material.dart';

class FeedsPage extends StatefulWidget {
  FeedsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FeedsPageState createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  FeedService feedService = FeedService();
  bool _isLoading = false;
  Feeds _feeds;
  int page = 1;
  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    fetchUsers();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          fetchMore();
        });
      }
    });

  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void fetchMore() async {
    if (page > _feeds.all_count / _feeds.page_size) {
      return;
    }

    if (!_isLoading) {
      _isLoading = true;

      ++page;

      var result = await feedService.getFeeds(page.toString());
      setState(() {
        if (result.data.length > 0) {
          _feeds.data.addAll(result.data);
        } else {
          --page;
        }
      });
      _isLoading = false;
    }
  }

  void fetchUsers() async {
    page = 1;
    var result = await feedService.getFeeds("1");
    setState(() {
      _feeds = result;
    });
  }

  Future<void> _getData() async {
    setState(() {
      fetchUsers();
    });
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditorPage()),
    );

    var res = jsonDecode(result);
    var data_res = res["data"];
    setState(() {
      _feeds.data.insert(0, Feed.fromJson(data_res));
      _feeds.all_count++;
    });
  }

  ListTile makeListTile(Feed feed) => ListTile(
    dense: true,

    contentPadding:
    EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    title: Text(
      feed.content,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

    subtitle: Row(
      children: <Widget>[
        Expanded(
          flex: 0,
          child: Padding(
              padding: EdgeInsets.only(left: 0.0, bottom: 0, top: 3),
              child: Text(feed.isAdmin ? "관리자" : feed.userId,
                  style: TextStyle(color: Colors.grey))),
        ),
        Expanded(
          flex: 0,
          child: Padding(
              padding: EdgeInsets.only(left: 5.0, bottom: 0, top: 3),
              child: Text(
                  DateTimeUtils.utcStringToLocalString(feed.created),
                  style: TextStyle(color: Colors.grey))),
        )
      ],
    ),
    trailing: SizedBox.fromSize(
      size: Size(40, 40), // button width and height
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.rate_review,
            color: Colors.white,
          ), // icon
          Text(
            feed.replyCount.toString(),
            style: TextStyle(color: Colors.white),
          ), // text
        ],
      ),
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FeedPage(title: 'Feed', id: feed.id)),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    if (_feeds == null)
      return Container(
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Center(child: CircularProgressIndicator()));

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text(widget.title),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateAndDisplaySelection(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }


  Card makeCard(Feed lesson) => Card(
    elevation: 3.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    child: Container(
      decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
      child: makeListTile(lesson),
    ),
  );


  Widget _buildBody(){
    return RefreshIndicator(
      onRefresh: _getData,
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8.0),
        itemCount: _feeds.data.length + 1,
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
          if (index == _feeds.data.length) {
            if (index == _feeds.all_count) {
              return new Padding(
                  padding: const EdgeInsets.all(8), child: new Center());
            }

            return new Padding(
                padding: const EdgeInsets.all(8),
                child: new Center(
                  child: new CircularProgressIndicator(),
                ));
          }

          if (index == 3 && Const.NativeAdCount == 0) {
            Const.NativeAdCount++;

            return Column(
              children: <Widget>[
                makeCard(_feeds.data[index]),
                FacebookNativeAd(
                  placementId: "610582579805224_613294499534032",
                  adType: NativeAdType.NATIVE_AD,
                  width: double.infinity,
                  height: 300,
                  backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                  titleColor: Colors.white,
                  descriptionColor: Colors.white,
                  buttonColor: Colors.white30,
                  buttonTitleColor: Colors.white,
                  buttonBorderColor: Color.fromRGBO(58, 66, 86, 1.0),
                  listener: (result, value) {
                    print("Native Ad: $result --> $value");
                  },
                ),
              ],
            );
          }
          return makeCard(_feeds.data[index]);
        },
      ),
    );
  }
}
