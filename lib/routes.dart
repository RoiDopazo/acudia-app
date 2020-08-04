import 'package:acudia/ui/screens/auth/signup/sign_up_screen.dart';
import 'package:acudia/ui/screens/auth/splash_page.dart';
import 'package:acudia/ui/screens/main/main_page.dart';
import 'package:flutter/widgets.dart';

class Routes {
  // Route name constants
  static const String SPLASH = '/';
  static const String SIGNUP = '/sign-up';
  static const String MAIN = '/main';

  /// The map used to define our routes, needs to be supplied to [MaterialApp]
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.SPLASH: (context) => SplashScreen(),
      Routes.SIGNUP: (context) => SignUpScreen(),
      Routes.MAIN: (context) => MainPage(),
    };
  }
}
