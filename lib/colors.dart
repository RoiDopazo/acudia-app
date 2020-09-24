import 'package:flutter/material.dart';

const aCBackground = const Color(0xFFF8F8F8);
const aCWhite = const Color(0xFFFFFFFF);
const aCErrorRed = const Color(0xFFC5032B);
const aCComplementary = const Color(0xFF962300);
const aCTextColor = const Color(0xFF000000);

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
  50: Color(0xFFE0F2F1),
  100: Color(0xFFB3E0DB),
  200: Color(0xFF80CBC4),
  300: Color(0xFF4DB6AC),
  400: Color(0xFF26A69A),
  500: Color(_aCPalettePrimaryValue),
  600: Color(0xFF008E80),
  700: Color(0xFF008375),
  800: Color(0xFF00796B),
  900: Color(0xFF006858),
});
const int _aCPalettePrimaryValue = 0xFF009688;

const MaterialColor aCPaletteAccent =
    MaterialColor(_aCPaletteAccentValue, <int, Color>{
  100: Color(0xFF425C5E),
  200: Color(_aCPaletteAccentValue),
  400: Color(0xFF1D393C),
  700: Color(0xFF183133),
});
const int _aCPaletteAccentValue = 0xFF213F42;
