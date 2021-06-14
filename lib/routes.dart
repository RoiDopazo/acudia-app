import 'package:acudia/components/generic_error.dart';
import 'package:acudia/core/providers/error_notifier_provider.dart';
import 'package:acudia/ui/screens/auth/signup/sign_up_screen.dart';
import 'package:acudia/ui/screens/auth/splash_page.dart';
import 'package:acudia/ui/screens/main/acudier/acudier_details_page.dart';
import 'package:acudia/ui/screens/main/acudier/availability/acudier_availability_page.dart';
import 'package:acudia/ui/screens/main/acudier/confirm/acudier_confirm_page.dart';
import 'package:acudia/ui/screens/main/hospital/assignments/hospital_assignments_config_page.dart';
import 'package:acudia/ui/screens/main/hospital/details/hospital_details_page.dart';
import 'package:acudia/ui/screens/main/hospital/search/hospital_search_page.dart';
import 'package:acudia/ui/screens/main/main_page.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

Widget buildRoute(widget) {
  return Consumer<ErrorNotifierProvider>(
      builder: (context, error, child) => new Stack(children: [widget, GenericError(errorProvider: error)]));
}

class Routes {
  // Route name constants
  static const String SPLASH = '/splash';
  static const String SIGNUP = '/sign-up';
  static const String MAIN = '/main';
  static const String SEARCH_HOSP = '/search-hosp';
  static const String HOSP_DETAILS = '/hosp-details';
  static const String HOSP_ASSIGNMENTS = '/hosp-assign';
  static const String ACUDIER_DETAILS = '/acudier-details';
  static const String ACUDIER_AVAILABILITY = '/acudier-availability';
  static const String ACUDIER_CONFIRM = '/acudier-confirm';


  /// The map used to define our routes, needs to be supplied to [MaterialApp]
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.MAIN: (context) => buildRoute(MainPage()),
      Routes.SIGNUP: (context) => buildRoute(SignUpScreen()),
      Routes.SPLASH: (context) => buildRoute(SplashScreen()),
      Routes.SEARCH_HOSP: (context) => buildRoute(HospitalSearchPage()),
      Routes.HOSP_DETAILS: (context) => buildRoute(HospitalDetailsPage()),
      Routes.HOSP_ASSIGNMENTS: (context) => buildRoute(HospitalAssignmentsConfigPage()),
      Routes.ACUDIER_DETAILS: (context) => buildRoute(AcudierDetailsPage()),
      Routes.ACUDIER_AVAILABILITY : (context) => buildRoute(AcudierAvailabiltyPage()),
      Routes.ACUDIER_CONFIRM: (context) => buildRoute(AcudierConfirmPage())
    };
  }
}
