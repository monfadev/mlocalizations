import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/preference/preference_util.dart';

class LocalizationProvider extends ChangeNotifier {
  /// Property Sections

  /// Detail of locale
  Locale? _locale;
  Locale? get locale => _locale;

  String? getPref;

  /// String preferences
  String localizationPref = "locale_pref";

  ///=========================

  /// Instance provider
  static LocalizationProvider instance(BuildContext context) => context.read();

  /// Function Logic Sections
  Future<void> initialize() async {
    final locale = await getLocale();

    if (locale != null) {
      _locale = locale;

      log('PROVIDER (initialize): $_locale');

      notifyListeners();
    }
  }

  Future<void> changeLocale(Locale locale, String languageCode) async {
    await PreferenceUtil.instance.setLocale(languageCode).then((value) {
      _locale = locale;
      switchLocale(languageCode);
    });
    notifyListeners();
  }

  Future<Locale?> getLocale() async {
    final locale = await PreferenceUtil.instance.getLocale();

    if (locale != null) {
      getPref = locale;
      log('PROVIDER (getPref): $getPref');

      if (getPref?.isEmpty == true) {
        log('PROVIDER (getPref?.isEmpty == true)');
        return null;
      }

      log('PROVIDER (getPref?.isEmpty == false)');
      return switchLocale(getPref!);
    }

    return null;
  }

  Locale switchLocale(String languageCode) {
    log('switchLocale: languageCode $languageCode');

    switch (languageCode) {
      case "en":
        _locale = Locale(LocalizationEnum.localeEN.locale);
        notifyListeners();
        return Locale(LocalizationEnum.localeEN.locale);
      case "id":
        _locale = Locale(LocalizationEnum.localeID.locale);
        notifyListeners();
        return Locale(LocalizationEnum.localeID.locale);
      default:
        return Locale(LocalizationEnum.localeEN.locale);
    }
  }

  void localePlatform() async {
    log('localePlatform: builder');
    log('localePlatform: $locale');
    log('localePlatform: Platform.localeName ${Platform.localeName}');
    log('localePlatform: getPref $getPref');

    final getLocal = await getLocale();
    log('localePlatform: getLocal $getLocal');
    if (getLocal == null) {
      if (getPref == null) {
        log('localePlatform: getPref == null');
        if (Platform.localeName == 'id_ID') {
          switchLocale('id');
        } else if (Platform.localeName == 'en_US') {
          switchLocale('en');
        }
        notifyListeners();
      } else {
        log('localePlatform: getPref != null');
      }
    }
  }
}

enum LocalizationEnum {
  localeEN("en"),
  localeID("id");

  final String locale;
  const LocalizationEnum(this.locale);

  @override
  String toString() => "Enum $name is $locale ";
}
