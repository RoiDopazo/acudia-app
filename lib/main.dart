import 'package:acudia/app-localizations.dart';
import 'package:acudia/core/providers/AuthProvider.dart';
import 'package:acudia/core/providers/CounterProvider.dart';
import 'package:acudia/ui/screens/HomePage.dart';
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
        Locale('en', 'US'),
        Locale('es', 'ES'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
