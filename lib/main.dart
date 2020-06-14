import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/providers/auth_provider.dart';
import 'package:acudia/core/providers/error_notifier_provider.dart';
import 'package:acudia/core/providers/sign_up_provider.dart';
import 'package:acudia/routes.dart';
import 'package:acudia/utils/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'colors.dart';

Future main() async {
  await Environment.loadEnvFile();
  runApp(
    MultiProvider(providers: [
      Provider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => SignUpProvider()),
      ChangeNotifierProvider(create: (context) => ErrorNotifierProvider()),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [
        Locale('es', 'ES'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: _aCTheme,
      initialRoute: Routes.Splash,
      routes: Routes.getRoutes(),
    );
  }
}

final ThemeData _aCTheme = _buildTheme();

ThemeData _buildTheme() {
  final ThemeData base = new ThemeData.light();
  final ThemeData finalTheme = new ThemeData(
      primarySwatch: aCPalette,
      primaryColorBrightness: Brightness.light,
      accentColor: aCPaletteAccent,
      primaryColor: aCPalette,
      secondaryHeaderColor: aCPalette,
      buttonColor: aCPalette,
      backgroundColor: aCBackground,
      scaffoldBackgroundColor: aCWhite,
      cardColor: aCWhite,
      textSelectionColor: aCPalette,
      errorColor: aCErrorRed,
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        buttonColor: aCPalette,
      ),
      appBarTheme: base.appBarTheme
          .copyWith(color: aCPalette, iconTheme: IconThemeData(color: aCWhite)),
      dialogBackgroundColor: aCWhite,
      primaryIconTheme: base.iconTheme.copyWith(color: aCTextColor),
      inputDecorationTheme: InputDecorationTheme(),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
      toggleButtonsTheme: _buildToggleButtonsTheme(base.toggleButtonsTheme));

  return finalTheme;
}

ToggleButtonsThemeData _buildToggleButtonsTheme(ToggleButtonsThemeData base) {
  return base.copyWith(
    fillColor: aCBackground,
    selectedColor: aCTextColor,
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base
      .copyWith(
          headline1: base.headline1.copyWith(
            fontSize: 48,
          ),
          headline2: base.headline2
              .copyWith(fontSize: 24, fontWeight: FontWeight.w500),
          headline3: base.headline3.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          headline4: base.headline4.copyWith(
            fontSize: 16,
          ),
          headline5: base.headline5.copyWith(
            fontSize: 14,
          ),
          headline6: base.headline6.copyWith(fontSize: 18.0),
          caption: base.caption.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
          bodyText1: base.bodyText1.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
          subtitle1: base.subtitle1.copyWith(
            color: aCTextColor,
          ))
      .apply(
        fontFamily: 'Rubik',
        displayColor: aCTextColor,
        bodyColor: aCTextColor,
      );
}
