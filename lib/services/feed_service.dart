//https://raw.githubusercontent.com/JoHwanhee/c-lecture/master/www/test11
import 'package:c_lecture/const.dart';
import 'package:c_lecture/model/feeds.dart';
import 'package:c_lecture/model/lectures.dart';
import 'package:c_lecture/util/util.dart';

class FeedService{
  Future<Feeds> getFeeds(String page) async {
    print(page);
    final url = Const.FeedServerUrl + "/feeds?page=$page";
    print(url);
    return Feeds.fromJson(await HttpUtil.httpGetBodyToJson(url));
  }

  Future<Feed> getFeed(String id) async {
    final url = Const.FeedServerUrl + "/feeds/$id";
    var res = await HttpUtil.httpGetBodyToJson(url);
    return Feed.fromJson(res['data']);
  }
  Future<String> post(String json) async {
    final url = Const.FeedServerUrl + "/feeds";
    return await HttpUtil.httpPost(url, json);
  }

  Future<String> postReply(String id, String json) async {
    final url = Const.FeedServerUrl + "/feeds/$id/replies";
    print(url);
    print(json);
    return await HttpUtil.httpPost(url, json);
  }

}