// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  String theme = 'light';
  SharedPreferences? preferences;
  LinearGradient? linearGradient;
  Color? backgroundColor;
  Color? backgroundColorCard;
  Color? iconColor;
  initialazie() async {
    preferences = await SharedPreferences.getInstance();
    if (!(preferences!.containsKey('theme'))) {
      preferences?.setString('theme', theme);
    } else {
      changeTheme(preferences?.get('theme'));
    }
  }

  changeTheme(newTheme) async {
    preferences = await SharedPreferences.getInstance();
    preferences?.setString('theme', newTheme);
    print('Current theme is: ${preferences!.get('theme').toString()}');
    theme = newTheme;
    linearGradient = (theme == 'light') ? lightModeGradient : darkModeGradient;
    backgroundColor = (theme == 'light') ? lightBackground : darkBackground;
    backgroundColorCard =
        (theme == 'light') ? lightBackgroundCard : darkBackgroundCard;
    iconColor = (theme == 'light') ? lightIcon : darkIcon;
    notifyListeners();
  }
}

LinearGradient lightModeGradient = const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.topRight,
  colors: <Color>[
    Color(0xffFFB100),
    Color(0xffEEAE1C),
    Color(0xffF5A64F),
  ],
);

LinearGradient darkModeGradient = const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.topRight,
  colors: <Color>[
    Color(0xff1E1E1E),
    Color(0xff141821),
    Color(0xff1d0332),
  ],
);

Color lightBackground = const Color(0xffF5F5F5);
Color darkBackground = const Color.fromARGB(29, 48, 48, 48);

Color darkBackgroundCard = const Color(0xff303030);
Color lightBackgroundCard = Colors.white;

Color lightIcon = Colors.black;
Color darkIcon = const Color(0xffEEAE1C);
//////////////////////
///for background in dark mode Color.fromARGB(29, 48, 48, 48)
///for background custom card in dark mode Color(0xff303030), in light mode Colors.white
///