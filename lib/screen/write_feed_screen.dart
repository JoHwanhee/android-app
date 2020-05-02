import 'dart:convert';

import 'package:c_lecture/services/feed_service.dart';
import 'package:c_lecture/util/util.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';


class EditorPage extends StatefulWidget {
  @override
  EditorPageState createState() => EditorPageState();
}

class EditorPageState extends State<EditorPage> {
  /// Allows to control the editor and the document.
  final TextEditingController _textController = new TextEditingController();


  /// Zefyr editor like any other input field requires a focus node.
  FocusNode _focusNode;

  @override
  void dispose() {
    // TODO: implement dispose
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    // Note that the editor requires special `ZefyrScaffold` widget to be
    // one of its parents.
    return Scaffold(
      appBar: AppBar(title: Text("질문하기"), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          tooltip: 'Send',
          onPressed: () {
            if (_textController == null) return;
            if (_textController.text == null) return;
            if (_textController.text.isEmpty) return;

            DeviceUtil.getId(context).then((res) {
              var data = {
                "user_id" : res,
                "content" : _textController.text,
                "created" : DateTimeUtils.getUtcString(),
                "is_notice" : false,
                "reply_count" : 0,
              };

              print(DateTimeUtils.utcStringToLocalString(DateTimeUtils.getUtcString().split('.')[0]));

              String json = jsonEncode(data);
              print(json);

              FeedService().post(json).then((res){
                print(res);
                Navigator.pop(context, res);
              });
            });

          },
        ),
      ],),
      body:

      Container(
        padding: EdgeInsets.all(8),
        child: TextField(

          controller: _textController,
          autofocus: true,
          keyboardType: TextInputType.multiline,
          maxLines: null,
        ),
      )
    );
  }
}