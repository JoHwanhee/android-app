class Feeds {
  String code;
  int all_count;
  int page;
  int page_size;

  List<Feed> data;

  Feeds({this.code, this.data});

  Feeds.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    all_count = json['all_count'];
    page = json['page'];
    page_size = json['page_size'];
    if (json['data'] != null) {
      data = new List<Feed>();
      json['data'].forEach((v) {
        data.add(new Feed.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['all_count'] = this.all_count;
    data['page'] = this.page;
    data['page_size'] = this.page_size;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Feed {
  String id;
  String userId;
  String content;
  String created;
  bool isNotice;
  int replyCount;
  bool isAdmin;
  List<Replies> replies;

  Feed(
      {this.id,
        this.userId,
        this.content,
        this.created,
        this.isNotice,
        this.replyCount,
        this.isAdmin,
        this.replies});

  Feed.fromJson(Map<String, dynamic> json) {
    id = json['_id']['\$oid'];
    userId = json['user_id'];
    content = json['content'];
    created = json['created'];
    isNotice = json['is_notice'];
    replyCount = json['reply_count'];
    isAdmin = json['is_admin'];
    if (json['replies'] != null) {
      replies = new List<Replies>();
      json['replies'].forEach((v) {
        replies.add(new Replies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['_id'] = this.id;
    data['user_id'] = this.userId;
    data['content'] = this.content;
    data['created'] = this.created;
    data['is_notice'] = this.isNotice;
    data['reply_count'] = this.replyCount;
    data['is_admin'] = this.isAdmin;
    if (this.replies != null) {
      data['replies'] = this.replies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Id {
  String oid;

  Id({this.oid});

  Id.fromJson(Map<String, dynamic> json) {
    oid = json['$oid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$oid'] = this.oid;
    return data;
  }
}

class Replies {
  String userId;
  String content;
  String created;

  Replies({this.userId, this.content, this.created});

  Replies.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    content = json['content'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['content'] = this.content;
    data['created'] = this.created;
    return data;
  }
}