import 'package:c_lecture/const.dart';
import 'package:c_lecture/model/lectures.dart';
import 'package:c_lecture/util/util.dart';

class LectureService{
    Future<Lectures> getLectures() async {
        final url = Const.LectureServerUrl + Const.IndexJsonPath;
        return Lectures.fromJson(await HttpUtil.httpGetBodyToJson(url));
    }

    Future<String> getContents(Lecture lecture) async {
        final url = Const.LectureServerUrl + lecture.path;
        return await HttpUtil.httpGetBody(url);
    }
}