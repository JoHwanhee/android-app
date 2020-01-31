import 'package:c_lecture/generated/json/base/json_convert_content.dart';

class LectureEntity with JsonConvert<LectureEntity> {
	List<LectureData> data;
}

class LectureData with JsonConvert<LectureData> {
	String title;
	String path;
}
