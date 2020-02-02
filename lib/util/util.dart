import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
}


