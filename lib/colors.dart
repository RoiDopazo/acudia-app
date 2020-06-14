import 'package:flutter/material.dart';

const aCPrimaryDark = const Color(0xFF83001c);
const aCBackground = const Color(0xFFF8EAED);
const aCWhite = const Color(0xFFFFFFFF);
const aCTextColor = const Color(0xFF442B2D);
const aCErrorRed = const Color(0xFFC5032B);

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

const MaterialColor aCPalette =
    MaterialColor(_aCPalettePrimaryValue, <int, Color>{
  50: Color(0xFFF8EAED),
  100: Color(0xFFEECBD2),
  200: Color(0xFFE3A9B4),
  300: Color(0xFFD88696),
  400: Color(0xFFCF6C80),
  500: Color(_aCPalettePrimaryValue),
  600: Color(0xFFC14B61),
  700: Color(0xFFBA4156),
  800: Color(0xFFB3384C),
  900: Color(0xFFA6283B),
});
const int _aCPalettePrimaryValue = 0xFFC75269;

const MaterialColor aCPaletteAccent =
    MaterialColor(_aCPaletteAccentValue, <int, Color>{
  100: Color(0xFFFFE6EA),
  200: Color(_aCPaletteAccentValue),
  400: Color(0xFFFF8091),
  700: Color(0xFFFF677B),
});
const int _aCPaletteAccentValue = 0xFFFFB3BD;
