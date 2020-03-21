import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:convert/convert.dart';
import 'package:labor_scanner/model/corona_test_case.dart';

class APIService {
  static const API_BASE_PATH = "https://google.com/";
  static Dio dio = new Dio();

  static Future<CoronaTestCase> update(final String url, final CoronaStatus infected) async {
    final Response response = await dio.patch(url);

    if (response.statusCode != 200)
      return null;

    return CoronaTestCase.fromJson(jsonDecode(response.data));
  }
}