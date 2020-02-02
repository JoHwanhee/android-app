
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
    double indicatorValue;

    Lecture({this.title, this.path, this.imagePath, this.level, this.indicatorValue});

    Lecture.fromJson(Map<String, dynamic> json) {
        title = json['title'];
        path = json['path'];
        imagePath = json['imagePath'];
        level = json['level'];
        indicatorValue = json['indicatorValue'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['title'] = this.title;
        data['path'] = this.path;
        data['imagePath'] = this.imagePath;
        data['level'] = this.level;
        data['indicatorValue'] = this.indicatorValue;

        return data;
    }
}