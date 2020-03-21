import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:labor_scanner/model/corona_test_case.dart';

class APIService {
  static const API_BASE_URL = 'https://blffmaku9b.execute-api.eu-central-1.amazonaws.com/Prod';

  /// Used to test if data in barcode is valid
  static const API_BASE_PATH = "/corona-test-case";
  static const API_URL = '$API_BASE_URL$API_BASE_PATH';
  static const API_TIMEOUT = 3000;
  static Dio dio = new Dio(BaseOptions(connectTimeout: API_TIMEOUT));

  static Future<CoronaTestCase> update(final String url, final CoronaStatus infected) async {
    if (!url.startsWith(API_BASE_PATH))
      return null;

    final finalUrl = '$API_BASE_URL$url/${infected.toString().split(".")[1]}';
    print(finalUrl);
    final Response response = await dio.patch(finalUrl);

    if (response.statusCode != 200)
      return null;

    return CoronaTestCase.fromJson(jsonDecode(response.data));
  }
}