
class Lectures {
    List<Lecture> data;

    Lectures({this.data});

    Lectures.fromJson(Map<String, dynamic> json) {
        if (json['data'] != null) {
            data = new List<Lecture>();
            json['data'].forEach((v) {
                data.add(new Lecture.fromJson(v));
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

class Lecture {
    String title;
    String path;
    String imagePath;
    String level;

    Lecture({this.title, this.path});

    Lecture.fromJson(Map<String, dynamic> json) {
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