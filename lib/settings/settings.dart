import 'package:labor_scanner/model/settings_status.dart';

class Settings {
  static SettingsStatus getSettings() {
    return SettingsStatus.UNKNOWN;
  }

  static bool updateSettings(final SettingsStatus status) {
    return false;
  }
}