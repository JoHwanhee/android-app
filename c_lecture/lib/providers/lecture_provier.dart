import 'package:c_lecture/model/lectures.dart';
import 'package:c_lecture/services/lecture_serivce.dart';
import 'package:flutter/material.dart';

class LectureProvider  with ChangeNotifier {
    Lectures lectures;
    bool loading = true;

    getLectures() async {
        setLoading(true);
        LectureService().getLectures().then((res) {
            setLectures(res);
            setLoading(false);
            
            print('provider');
            return lectures;
        });
    }

    void setLoading(value) {
        loading = value;
        notifyListeners();
    }

    void setLectures(value) {
        lectures = value;
        notifyListeners();
    }

    bool isLoading() {
        return loading;
    }
}
