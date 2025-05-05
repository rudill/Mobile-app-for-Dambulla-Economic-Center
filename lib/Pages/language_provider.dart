import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  String _languageCode = 'si';

  String get languageCode => _languageCode;

  void changeLanguage(String lang) {
    _languageCode = lang;
    notifyListeners();
  }
}
