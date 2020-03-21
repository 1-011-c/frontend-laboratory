import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labor_scanner/event/settings_event.dart';
import 'package:labor_scanner/model/settings_status.dart';
import 'package:labor_scanner/settings/settings.dart';
import 'package:labor_scanner/state/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is GetSettings) {
      switch(Settings.getSettings()) {
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
  }

  @override
  SettingsState get initialState => UnknownTestingSettingsState();

}