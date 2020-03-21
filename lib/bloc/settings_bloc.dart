import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labor_scanner/event/settings_event.dart';
import 'package:labor_scanner/model/settings_status.dart';
import 'package:labor_scanner/service/settings_service.dart';
import 'package:labor_scanner/state/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is GetSettings) {
      switch(await SettingsService.getSettings()) {
        case SettingsStatus.UNKNOWN:
          yield UnknownTestingSettingsState();
          break;
        case SettingsStatus.POSITIVE:
          yield PositiveTestingSettingsState();
          break;
        case SettingsStatus.NEGATIVE:
          yield NegativeTestingSettingsState();
          break;
      }
    }

    if (event is UpdateSettings) {
      SettingsService.updateSettings(event.status);
    }
  }

  @override
  SettingsState get initialState => UnknownTestingSettingsState();

}