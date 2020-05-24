import 'package:flutter/material.dart';

enum IntentStyles { Primary, Success, Warning, Error }

// ignore: non_constant_identifier_names
final ThemeData CompanyThemeData = new ThemeData(
    brightness: Brightness.light,
    primaryColor: CompanyColors.blue[100],
    primaryColorBrightness: Brightness.light,
    accentColor: Colors.blue,
    disabledColor: Colors.grey[300],
    backgroundColor: Colors.white,
    textSelectionColor: Colors.white,
    accentColorBrightness: Brightness.light,
    textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: CompanyColors.blue[100]),
        headline1: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
        headline2: TextStyle(
            color: CompanyColors.blue[100],
            fontWeight: FontWeight.bold,
            fontSize: 16),
        headline3: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)));

class CompanyColors {
  CompanyColors._(); // this basically makes it so you can instantiate this class
  static const Map<int, Color> blue = const <int, Color>{
    100: const Color(0xFF3182cc),
  };

  // static const Map<int, Color> green = const <int, Color>{
  //   50: const Color(/* some hex code */),
  //   100: const Color(/* some hex code */),
  //   200: const Color(/* some hex code */),
  //   300: const Color(/* some hex code */),
  //   400: const Color(/* some hex code */),
  //   500: const Color(/* some hex code */),
  //   600: const Color(/* some hex code */),
  //   700: const Color(/* some hex code */),
  //   800: const Color(/* some hex code */),
  //   900: const Color(/* some hex code */)
  // };
}
