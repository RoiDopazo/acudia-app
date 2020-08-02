import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/aws/cognito_exceptions.dart';
import 'package:acudia/core/aws/cognito_service.dart';
import 'package:acudia/core/providers/error_notifier_provider.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';

const FIELD_NAME = 'name';
const FIELD_EMAIL = 'email';
const FIELD_PASSWORD = 'password';
const FIELD_GENDER = 'gender';
const FIELD_ROLE = 'role';
const FIELD_BIRTHDATE = 'birthdate';
const FIELD_IMAGE = 'image';

class SignUpProvider with ChangeNotifier {
  bool showLogin = false;
  int selectedTab = 0;
  bool isRegistered = false;
  String verificationCode = '';
  final values = {
    FIELD_NAME: '',
    FIELD_EMAIL: '',
    FIELD_PASSWORD: '',
    FIELD_ROLE: [false, false],
    FIELD_GENDER: [false, false, false],
    FIELD_BIRTHDATE: null,
    FIELD_IMAGE: null,
  };

  final errors = {
    FIELD_ROLE: '',
    FIELD_GENDER: '',
    FIELD_BIRTHDATE: '',
  };

  setSelectedTab(tab) {
    if (tab >= 0 && tab <= 2) {
      if (tab == 2 && !isRegistered) {
        return;
      }
      selectedTab = tab;
      notifyListeners();
    }
  }

  setVerificationCode(code) {
    verificationCode = code;
    notifyListeners();
  }

  setToggleLogin() {
    showLogin = !showLogin;
    notifyListeners();
  }

  updateValue(key, value) {
    values[key] = value;
    errors[key] = '';
    if (key == FIELD_ROLE && value[0]) {
      values[FIELD_GENDER] = [false, false, false];
      values[FIELD_BIRTHDATE] = null;
    }
    notifyListeners();
  }

  validate() {
    final List<bool> roleValues = values[FIELD_ROLE];
    final List<bool> genderValues = values[FIELD_GENDER];
    var fails = false;

    if (roleValues.every((item) => item == false)) {
      errors[FIELD_ROLE] = 'field_role_validation_empty';
      fails = true;
    }

    // If is acudier validate
    if (roleValues[1] == true) {
      if (genderValues.every((item) => item == false)) {
        errors[FIELD_GENDER] = 'field_gender_validation_empty';
        fails = true;
      }
      if (values[FIELD_BIRTHDATE] == null) {
        errors[FIELD_BIRTHDATE] = 'field_birthdate_validation_empty';
        fails = true;
      }
    }

    notifyListeners();
    return fails;
  }

  login(context) async {
    try {
      CognitoUserSession session =
          CognitoService.login("rdopazobucket@gmail.com", "Aaaa1234");
      print(session.getAccessToken().getJwtToken());
    } catch (error) {
      print(error);
    }
  }

  signUp(context) async {
    try {
      var user = await CognitoService.signUp(
          values[FIELD_NAME], values[FIELD_EMAIL], values[FIELD_PASSWORD]);
      if (!user.userConfirmed) {
        isRegistered = true;
        selectedTab = 2;
        notifyListeners();
      }
    } on CustomCognitoUsernameExistsException catch (e) {
      showError(
          context,
          translate(context, 'error_creating_account'),
          translate(context, 'error_creating_account_username_exists'),
          ERROR_VISUALIZATIONS_TYPE.dialog);
    }
  }

  verifyEmail(context, email, code) {
    try {
      CognitoService.verifyEmail(email, code);
    } catch (error) {
      return showError(
          context,
          translate(context, 'error_unexpected'),
          translate(context, 'error_try_again_later'),
          ERROR_VISUALIZATIONS_TYPE.dialog);
    }
  }

  resendVerificationCode(context, email) async {
    try {
      await CognitoService.resendVerificationCode(email);
    } catch (error) {
      if (error.statusCode == 400 && error.code == 'LimitExceededException') {
        return showError(
            context,
            translate(context, 'error_limit_exceeded'),
            translate(context, 'error_try_again_later'),
            ERROR_VISUALIZATIONS_TYPE.dialog);
      }
      return showError(
          context,
          translate(context, 'error_unexpected'),
          translate(context, 'error_try_again_later'),
          ERROR_VISUALIZATIONS_TYPE.dialog);
    }
  }
}
