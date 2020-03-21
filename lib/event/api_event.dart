import 'package:equatable/equatable.dart';
import 'package:labor_scanner/model/corona_test_case.dart';
import 'package:meta/meta.dart';

abstract class APIEvent extends Equatable {
  const APIEvent();

  @override
  List<Object> get props => [];
}

class UpdateAPIEvent extends APIEvent {
  final String url;
  final CoronaStatus infected;

  const UpdateAPIEvent({@required this.url, @required this.infected});
}
