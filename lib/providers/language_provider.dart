// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  String lang = 'en';
  SharedPreferences? preferences;

  initialazie() async {
    preferences = await SharedPreferences.getInstance();
    if (!(preferences!.containsKey('lang'))) {
      preferences?.setString('lang', lang);
    } else {
      changeLanguage(preferences?.get('lang'));
    }
  }

  changeLanguage(newLanguage) async {
    preferences = await SharedPreferences.getInstance();
    preferences?.setString('lang', newLanguage);
    print(
        'The current language from preferences is: ${preferences!.getString('lang').toString()}');
    lang = newLanguage;
    notifyListeners();
  }
}
