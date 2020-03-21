import 'package:labor_scanner/model/corona_test_case.dart';

extension CoronaEnumExtension on CoronaStatus {

  String name() {
    return this.toString().split(".").last;
  }

}