import 'package:acudia/app_localizations.dart';
import 'package:acudia/company_theme.dart';
import 'package:acudia/core/providers/auth_provider.dart';
import 'package:acudia/core/providers/counter_provider.dart';
import 'package:acudia/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CounterProvider()),
          Provider(create: (context) => AuthProvider()),
        ],
        child: MyApp(),
      ),
    );

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
      theme: CompanyThemeData,
      initialRoute: Routes.Splash,
      routes: Routes.getRoutes(),
    );
  }
}
