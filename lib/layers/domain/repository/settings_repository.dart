import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matule/layers/domain/models/settings.dart';
import 'package:uuid/uuid.dart';

// prefs: settings
abstract class SettingsRepository {
  late Settings settings;
  static final String pref = 'settings';

  Future<Settings> updateSettings(Settings settings) async {
    await loadSettings();
    return await _saveSettings(settings);
  }

  Future<Settings> loadSettings() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? jsonSettings = sharedPreferences.getString(pref);

    if (jsonSettings != null) {
      this.settings = Settings.fromMap(json.decode(jsonSettings));
      return this.settings;
    } else {
      this.settings = Settings(
        uuid: Uuid().v1(),
        code: null,
        token: '',
        userid: '',
        notification: true,
      );
      await sharedPreferences.setString(
        pref,
        json.encode(this.settings.toMap()),
      );
      return this.settings;
    }
  }

  Future<Settings> _saveSettings(Settings settings) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(pref, json.encode(settings.toMap()));
    String? updatedSettings = await sharedPreferences.getString(pref);
    if (updatedSettings != null) {
      this.settings = Settings.fromMap(json.decode(updatedSettings));
      return this.settings;
    }
    debugPrint('Settings repository broken!');
    return this.settings;
  }

  // Future<Settings> removeSettings ();
}
