import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {

  @override
  List<Object> get props => [];

}

class UnknownTestingSettingsState extends SettingsState {}
class PositiveTestingSettingsState extends SettingsState {}
class NegativeTestingSettingsState extends SettingsState {}