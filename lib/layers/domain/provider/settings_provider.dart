import 'dart:async';

import 'package:matule/layers/domain/models/settings.dart';
import 'package:matule/layers/domain/repository/settings_repository.dart';

class SettingsProvider extends SettingsRepository {
  SettingsProvider();

  Future<Settings> getSettings() async {
    return await loadSettings();
  }

  /// Clear the user App Setting
  /// ex: code, notif... and token
  Future<Settings> logout() async {
    Settings _currentSettings = await loadSettings();
    _currentSettings.code = null;
    _currentSettings.token = '';
    _currentSettings.userid = '';
    throw Exception('Setting provider are broken!');
  }
}
