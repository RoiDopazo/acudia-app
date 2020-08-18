import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/aws/cognito_service.dart';
import 'package:acudia/core/providers/error_notifier_provider.dart';
import 'package:acudia/core/providers/sign_up_provider.dart';
import 'package:acudia/core/services/auth_link.dart';
import 'package:acudia/routes.dart';
import 'package:acudia/utils/constants.dart';
import 'package:acudia/utils/environment.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:load/load.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'colors.dart';

Future main() async {
  await Environment.loadEnvFile();
  final prefs = await SharedPreferences.getInstance();
  Credentials().init(prefs);
  CognitoUserSession userSession = await CognitoService.getUserData();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => SignUpProvider()),
      ChangeNotifierProvider(create: (context) => ErrorNotifierProvider()),
    ], child: MyApp(userSession: userSession)),
  );
}

class MyApp extends StatelessWidget {
  final CognitoUserSession userSession;

  const MyApp({@required this.userSession});

  @override
  Widget build(BuildContext context) {
    var authLink = CustomAuthLink()
        .concat(HttpLink(uri: "$AWS_APP_SYNC_ENDPOINT/graphql"));

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: InMemoryCache(),
        link: authLink,
      ),
    );

    return LoadingProvider(
        themeData: LoadingThemeData(
            tapDismiss: false, loadingBackgroundColor: Colors.transparent),
        loadingWidgetBuilder: (ctx, data) {
          return Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: Container(
                  child: new Theme(
                      data: Theme.of(context).copyWith(accentColor: aCPalette),
                      child: SpinKitFadingCircle(
                        size: 80,
                        color: aCPalette,
                      ))),
            ),
          );
        },
        child: GraphQLProvider(
            client: client,
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
              initialRoute: userSession != null && userSession.isValid()
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
