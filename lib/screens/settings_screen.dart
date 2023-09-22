import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../AppLocale.dart';
import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0.0,
          scrolledUnderElevation: 1.0,
          title: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              AppLocale.of(context).translate('mySettings')!,
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 30.0),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: Provider.of<ThemeProvider>(context).linearGradient),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: Provider.of<ThemeProvider>(context).linearGradient),
        child: Container(
          width: double.infinity,
          height: 605.491,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Provider.of<ThemeProvider>(context).backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              top: 15,
              right: 8.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocale.of(context).translate('appearance')!,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .changeTheme('light');
                  },
                  child: ListTile(
                    title: Text(AppLocale.of(context).translate('light')!),
                    trailing: Radio<String>(
                      value: 'light',
                      groupValue: Provider.of<ThemeProvider>(context).theme,
                      onChanged: (String? value) {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .changeTheme(value);
                      },
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .changeTheme('dark');
                  },
                  child: ListTile(
                    title: Text(AppLocale.of(context).translate('dark')!),
                    trailing: Radio<String>(
                      value: 'dark',
                      groupValue: Provider.of<ThemeProvider>(context).theme,
                      onChanged: (String? value) {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .changeTheme(value);
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocale.of(context).translate('language')!,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .changeTheme('light');
                  },
                  child: ListTile(
                    title: Text(AppLocale.of(context).translate('arabic')!),
                    trailing: Radio<String>(
                      value: 'ar',
                      groupValue: Provider.of<LanguageProvider>(context).lang,
                      onChanged: (String? value) {
                        {
                          Provider.of<LanguageProvider>(context, listen: false)
                              .changeLanguage(value);
                        }
                      },
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Provider.of<LanguageProvider>(context, listen: false)
                        .changeLanguage('en');
                  },
                  child: ListTile(
                    title: Text(AppLocale.of(context).translate('english')!),
                    trailing: Radio<String>(
                      value: 'en',
                      groupValue: Provider.of<LanguageProvider>(context).lang,
                      onChanged: (String? value) {
                        Provider.of<LanguageProvider>(context, listen: false)
                            .changeLanguage(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
