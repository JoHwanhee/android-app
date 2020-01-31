import 'package:c_lecture/model/lecture_entity.dart';

lectureEntityFromJson(LectureEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new List<LectureData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new LectureData().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> lectureEntityToJson(LectureEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	return data;
}

lectureDataFromJson(LectureData data, Map<String, dynamic> json) {
	if (json['title'] != null) {
		data.title = json['title']?.toString();
	}
	if (json['path'] != null) {
		data.path = json['path']?.toString();
	}
	return data;
}

Map<String, dynamic> lectureDataToJson(LectureData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['title'] = entity.title;
	data['path'] = entity.path;
	return data;
}