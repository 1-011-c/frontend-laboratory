enum SettingsStatus {
  UNKNOWN,
  POSITIVE,
  NEGATIVE
}

SettingsStatus getSettingStatusFromString(String setting) {
  return SettingsStatus.values.firstWhere((f)=> f.toString() == setting, orElse: () => null);
}