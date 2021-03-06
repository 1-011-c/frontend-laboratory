import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labor_scanner/event/settings_event.dart';
import 'package:labor_scanner/model/settings_status.dart';
import 'package:labor_scanner/service/settings_service.dart';
import 'package:labor_scanner/state/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is GetSettingsEvent) {
      yield mapStatusToState(await SettingsService.getSettings());
    }

    if (event is UpdateSettingsEvent) {
      SettingsService.updateSettings(event.status);
      yield mapStatusToState(await SettingsService.getSettings());
    }
  }

  SettingsState mapStatusToState(final SettingsStatus status) {
    switch(status) {
      case SettingsStatus.UNKNOWN:
        return UnknownTestingSettingsState();
      break;
      case SettingsStatus.POSITIVE:
        return PositiveTestingSettingsState();
      break;
      case SettingsStatus.NEGATIVE:
        return NegativeTestingSettingsState();
      break;
    }

    return null;
  }

  SettingsState getInitial() {
    
  }

  @override
  SettingsState get initialState => UnknownTestingSettingsState();

}