import 'dart:developer';

import 'package:flutter/material.dart';

class NotifyProvider extends ChangeNotifier {
  void notify() {
    log('NotifyProvider: notify');
    notifyListeners();
  }
}
