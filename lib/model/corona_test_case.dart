import 'package:flutter/cupertino.dart';

enum CoronaStatus {
  NOT_TESTED,
  IN_PROGRESS,
  POSITIVE,
  NEGATIVE
}

class CoronaTestCase {
  final String uuidRead;
  final String uuidWrite;
  final CoronaStatus infected;
  final String date;

  const CoronaTestCase({
    @required this.uuidRead,
    @required this.uuidWrite,
    @required this.infected,
    @required this.date
  });
}