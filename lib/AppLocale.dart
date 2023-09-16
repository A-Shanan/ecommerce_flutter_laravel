import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class AppLocale {
  Locale locale;
  // Locale locale;
  Map<String, String>? _translations;
  AppLocale(this.locale);
  static AppLocale of(BuildContext context) {
    return Localizations.of(context, AppLocale);
  }

  Future loadLangFile() async {
    String _loadedFile = await rootBundle
        .loadString('assets/languages/${locale.languageCode}.json');
    Map<String, dynamic> _loadedValues = jsonDecode(_loadedFile);
    _translations = _loadedValues.map(
      (key, value) => MapEntry(
        key,
        value.toString(),
      ),
    );
  }

  String? translate(String key) {
    return _translations?[key];
  }

  static LocalizationsDelegate<AppLocale> delegate = AppLocaleDeleget();
}

class AppLocaleDeleget extends LocalizationsDelegate<AppLocale> {
  const AppLocaleDeleget();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocale> load(Locale locale) async {
    AppLocale appLocale = AppLocale(locale);
    await appLocale.loadLangFile();
    return appLocale;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocale> old) {
    return false;
  }
}
