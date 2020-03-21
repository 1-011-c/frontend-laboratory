import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:labor_scanner/model/corona_test_case.dart';

class APIService {
  static const API_BASE_PATH = "https://blffmaku9b.execute-api.eu-central-1.amazonaws.com/Prod/corona-test-case";
  static const API_TIMEOUT = 3000;
  static Dio dio = new Dio(BaseOptions(connectTimeout: API_TIMEOUT));

  static Future<CoronaTestCase> update(final String url, final CoronaStatus infected) async {
    if (!url.startsWith(API_BASE_PATH))
      return null;

    final Response response = await dio.patch('$url/${infected.toString().split(".")[1]}');

    if (response.statusCode != 200)
      return null;

    return CoronaTestCase.fromJson(jsonDecode(response.data));
  }
}