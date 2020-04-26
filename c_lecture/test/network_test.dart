
// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:c_lecture/services/lecture_serivce.dart';
import 'package:flutter_test/flutter_test.dart';



void main() {
    test('Counter increments smoke test', () async {
        LectureService lectureService = LectureService();
        var lectures = await lectureService.getLectures();
        print(lectures.data[0].title);
        print(lectures.data[0].path);
        expect(lectures.data[0].title, "1. 프로그래밍이란 무엇인가.");
    });
}






