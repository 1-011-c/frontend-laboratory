import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:labor_scanner/model/corona_test_case.dart';

class APIService {
  static const API_BASE_PATH = "https://google.com/";
  static const API_TIMEOUT = 3000;
  static Dio dio = new Dio(BaseOptions(connectTimeout: API_TIMEOUT));

  static Future<CoronaTestCase> update(final String url, final CoronaStatus infected) async {
    if (!url.startsWith(API_BASE_PATH))
      return null;

    final Response response = await dio.patch(url);

    if (response.statusCode != 200)
      return null;

    return CoronaTestCase.fromJson(jsonDecode(response.data));
  }
}