
// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:c_lecture/main.dart';
import 'package:http/http.dart' as http;

void main() {
    test('Counter increments smoke test', () async {
        var lectures = await GetLectures();
        print(lectures.data[0].title);
        expect(lectures.data == null, false);
    });
}


Future<Lectures> GetLectures() async {
    final url = Const.LectureServerUrl + Const.IndexJsonPath;
    var res = await http.get(url);
    var json = utf8.decode(res.bodyBytes);
    return Lectures.fromJson(jsonDecode(json));
}

class Const {
    static const String LectureServerUrl = "https://amazing-jepsen-a459f1.netlify.com";
    static const String IndexJsonPath = "/index.json";

}


class Lectures {
    List<Data> data;

    Lectures({this.data});

    Lectures.fromJson(Map<String, dynamic> json) {
        if (json['data'] != null) {
            data = new List<Data>();
            json['data'].forEach((v) {
                data.add(new Data.fromJson(v));
            });
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Data {
    String title;
    String path;

    Data({this.title, this.path});

    Data.fromJson(Map<String, dynamic> json) {
        title = json['title'];
        path = json['path'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['title'] = this.title;
        data['path'] = this.path;
        return data;
    }
}