//https://raw.githubusercontent.com/JoHwanhee/c-lecture/master/www/test11
import 'package:c_lecture/const.dart';
import 'package:c_lecture/model/feeds.dart';
import 'package:c_lecture/model/lectures.dart';
import 'package:c_lecture/util/util.dart';

class RegService{
  Future<String> postDevice(String json) async {
    final url = Const.FeedServerUrl + "/devices";
    return await HttpUtil.httpPost(url, json);
  }
}