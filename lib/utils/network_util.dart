import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

// https://medium.com/@kashifmin/flutter-login-app-using-rest-api-and-sqflite-b4815aed2149
final BASE_URL_GET =
    "http://192.168.1.190:8080/api/izi-timekeeper/Controller/GetAllByWhat.php";
final BASE_URL_POST =
    "http://192.168.1.190:8080/api/izi-timekeeper/Controller/GetAllByWhat.php";
final _API_KEY = "somerandomkey";
//home ip: 192.168.1.190
//library ip : 172.20.46.9
//company ip : 192.168.0.108 | 192.168.1.18 | 192.168.1.12 | 192.168.0.103
class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(input) {
    String url = BASE_URL_GET + '?input=' + input;

    return http.get(url).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post({Map headers, body, encoding}) {
    String url = BASE_URL_POST;

    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }
}
