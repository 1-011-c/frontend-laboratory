import 'package:labor_scanner/model/settings_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String KEY_STATUS = "status";

class SettingsService {
  static Future<SettingsStatus> getSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String status = prefs.getString(KEY_STATUS);

    if (status == null)
      return SettingsStatus.UNKNOWN;

    return getSettingStatusFromString(status);
  }

  static Future<void> updateSettings(final SettingsStatus status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_STATUS, status.toString());
  }
}