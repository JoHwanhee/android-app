import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HexColor extends Color {
    HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

    static int _getColorFromHex(String hexColor) {
        hexColor = hexColor.toUpperCase().replaceAll('#', '');
        if (hexColor.length == 6) {
            hexColor = 'FF' + hexColor;
        }
        return int.parse(hexColor, radix: 16);
    }
}

class HttpUtil {
    static Future<Map<String, dynamic>> httpGetBodyToJson(String url) async {
        var res = await http.get(url);
        var json = utf8.decode(res.bodyBytes);
        return jsonDecode(json);
    }

    static Future<String> httpGetBody(String url) async {
        var res = await http.get(url);
        return utf8.decode(res.bodyBytes);
    }

    static Future<String> httpPost(String url, String body) async {
        final res = await http.post(
            url,
            body: body,
            headers: {'Content-Type': "application/json"},
        );
        return utf8.decode(res.bodyBytes);
    }
}

class DateTimeUtils {
    static const String timeforamt ="yyyy-MM-dd HH:mm:ss";

    static String utcStringToLocalString(utc_string) {
        var dateTime = DateFormat(timeforamt).parse(utc_string, true);
        var dateLocal = dateTime.toLocal();
        return new DateFormat(timeforamt).format(dateLocal);
    }

    static String getUtcString(){
        var now = DateTime.now().toUtc();
        return new DateFormat(timeforamt).format(now);
    }
}

class DeviceUtil {

    static Future<String> getId(context) async {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        if (Theme.of(context).platform == TargetPlatform.iOS) {
            IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
            return iosDeviceInfo.identifierForVendor; // unique ID on iOS
        } else {
            AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
            print(androidDeviceInfo.androidId);
            return androidDeviceInfo.androidId; // unique ID on Android
        }
    }
}