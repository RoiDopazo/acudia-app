import 'package:acudia/ui/screens/auth/splash_page.dart';
import 'package:flutter/widgets.dart';

class Routes {
  // Route name constants
  static const String Splash = '/';
  static const String SignUp = '/sign-up';

  /// The map used to define our routes, needs to be supplied to [MaterialApp]
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.Splash: (context) => SplashScreen(),
    };
  }
}
