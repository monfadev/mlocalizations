import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/localization/notify_provider.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
}

extension NotifyLanguage on Widget {
  Widget localeNotify() {
    log('localeNotify');
    return Consumer<NotifyProvider>(
      builder: (context, value, child) {
        return child!;
      },
      child: this,
    );
  }
}
