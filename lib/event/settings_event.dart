import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:labor_scanner/model/settings_status.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class GetSettings extends SettingsEvent {}

class UpdateSettings extends SettingsEvent {
  final SettingsStatus status;

  const UpdateSettings({@required this.status});
}