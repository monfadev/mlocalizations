import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/preference/preference_util.dart';

class LocalizationProvider extends ChangeNotifier {
  /// Property Sections

  /// Detail of locale
  Locale? _locale;
  Locale? get locale => _locale;

  /// String preferences
  String localizationPref = "locale_pref";

  ///=========================

  /// Instance provider
  static LocalizationProvider instance(BuildContext context) => context.read();

  /// Function Logic Sections
  Future<void> initialize() async {
    await getLocale().then((element) {
      _locale = element;
    });
    notifyListeners();
  }

  Future<void> changeLocale(Locale locale, String languageCode) async {
    await PreferenceUtil.instance.setLocale(languageCode).then((value) {
      _locale = locale;
      switchLocale(languageCode);
    });
    notifyListeners();
  }

  Future<Locale> getLocale() async {
    String? getPref;

    await PreferenceUtil.instance.getLocale().then((value) {
      getPref = value;
    });

    return switchLocale(getPref ?? LocalizationEnum.localeEN.locale);
  }

  Locale switchLocale(String languageCode) {
    switch (languageCode) {
      case "en":
        return Locale(LocalizationEnum.localeEN.locale);
      case "id":
        return Locale(LocalizationEnum.localeID.locale);
      default:
        return Locale(LocalizationEnum.localeEN.locale);
    }
  }

  ///=========================
}

enum LocalizationEnum {
  localeEN("en"),
  localeID("id");

  final String locale;
  const LocalizationEnum(this.locale);

  @override
  String toString() => "Enum $name is $locale ";
}
