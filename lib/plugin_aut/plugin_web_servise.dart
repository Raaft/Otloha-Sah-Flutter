import 'dart:async';
import 'dart:convert' show base64, utf8;

import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();
  static String clientId = 'VFvrohediCdsx7mcmoEeud09ANiIP4QyPK5IHI87';
  static String clientSecret = 'VFvrohediCdsx7mcmoEeud09ANiIP4QyPK5IHI87';
  static String auth = '$clientId:$clientSecret';
  static String encoded =
      base64.encode(utf8.encode(auth));

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: '165.232.114.22',
      receiveDataWhenStatusError: true,
      headers: {
        'Authorization': 'Basic $encoded',
        'Cache-Control': ' no-cache',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    ));
  }

  static Future<Response> postData({
    required String url,
    data,
    required Map<String, dynamic> query,
  }) async {
    //dio.options.headers = {};
    return await dio.post(url, data: data, queryParameters: query);
  }
}
