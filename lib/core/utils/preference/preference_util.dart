import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtil {
  PreferenceUtil._private();

  static PreferenceUtil instance = PreferenceUtil._private();

  late final SharedPreferences _prefs;

  String localizationPref = "locale_pref";

  Future<void> initializePreference() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setLocale(String languageCode) async {
    await _prefs.setString(localizationPref, languageCode);
  }

  Future<String?> getLocale() async {
    String locale = _prefs.getString(localizationPref) ?? '';
    log('PREFERENCE UTIL (getLocale): $locale');

    if (locale.isEmpty) {
      return null;
    }

    return locale;
  }
}
