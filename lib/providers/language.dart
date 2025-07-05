import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void toggleLocale() {
    _locale =
        _locale.languageCode == 'en' ? const Locale('ar') : const Locale('en');
    notifyListeners();
  }
}
