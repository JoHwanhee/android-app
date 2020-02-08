import 'package:c_lecture/providers/app_provider.dart';
import 'package:c_lecture/util/consts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  final String title;

  SettingPage({Key key, this.title}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List items = [
    {
      "icon": Icons.pageview,
      "title": "Favorites",
    },
    {
      "icon": Icons.exit_to_app,
      "title": "Exit",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text(widget.title),
    );

    return Scaffold(
      appBar: topAppBar,
      body:  ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {

          return ListTile(
            onTap: (){

            },
            leading: Icon(
              items[index]['icon'],
            ),
            title: Text(
              items[index]['title'],
            ),

          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }
}
