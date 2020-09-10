import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/aws/cognito_service.dart';
import 'package:acudia/core/providers/app_provider.dart';
import 'package:acudia/core/providers/error_notifier_provider.dart';
import 'package:acudia/core/providers/hospital_provider.dart';
import 'package:acudia/core/providers/profile_provider.dart';
import 'package:acudia/core/providers/sign_up_provider.dart';
import 'package:acudia/core/services/graphql_client.dart';
import 'package:acudia/routes.dart';
import 'package:acudia/utils/environment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:load/load.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'colors.dart';

Future main() async {
  await Environment.loadEnvFile();
  final prefs = await SharedPreferences.getInstance();
  Credentials().init(prefs);
  Map<String, dynamic> userData = await CognitoService.getUserData();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ErrorNotifierProvider()),
      ChangeNotifierProvider(create: (context) => AppProvider()),
      ChangeNotifierProvider(create: (context) => ProfileProvider()),
      ChangeNotifierProvider(create: (context) => SignUpProvider()),
      ChangeNotifierProvider(create: (context) => HospitalProvider()),
    ], child: MyApp(userData: userData)),
  );
}

class MyApp extends StatelessWidget {
  final Map<String, dynamic> userData;

  const MyApp({@required this.userData});

  @override
  Widget build(BuildContext context) {
    if (userData != null && userData["user"] != null) {
      Provider.of<ProfileProvider>(context, listen: false)
          .getProfileData(context, userData["user"]);
    }

    return LoadingProvider(
        themeData: LoadingThemeData(
            tapDismiss: false, loadingBackgroundColor: Colors.transparent),
        loadingWidgetBuilder: (ctx, data) {
          return Center(
            child: SizedBox(
                child: new Theme(
              data:
                  Theme.of(context).copyWith(accentColor: _aCTheme.accentColor),
              child: new CircularProgressIndicator(),
            )),
          );
        },
        child: GraphQLProvider(
            client: graphQLClient,
            child: MaterialApp(
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
              initialRoute: userData != null && userData['session'].isValid()
                  ? Routes.MAIN
                  : Routes.SPLASH,
              routes: Routes.getRoutes(),
            )));
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
      hintColor: aCPaletteAccent,
      cardColor: aCWhite,
      errorColor: aCErrorRed,
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        buttonColor: aCPalette,
        disabledColor: aCPalette,
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
    fillColor: aCPalette.shade100,
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
              .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
          headline3: base.headline3.copyWith(
            fontSize: 18,
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
