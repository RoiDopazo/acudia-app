import 'package:acudia/core/aws/cognito_exceptions.dart';
import 'package:acudia/core/aws/cognito_service.dart';
import 'package:acudia/core/providers/error_notifier_provider.dart';
import 'package:flutter/material.dart';

const FIELD_NAME = 'name';
const FIELD_EMAIL = 'email';
const FIELD_PASSWORD = 'password';
const FIELD_GENDER = 'gender';
const FIELD_ROLE = 'role';
const FIELD_BIRTHDATE = 'birthdate';

class SignUpProvider with ChangeNotifier {
  int selectedTab = 0;
  bool isRegistered = false;
  final values = {
    FIELD_NAME: '',
    FIELD_EMAIL: '',
    FIELD_PASSWORD: '',
    FIELD_ROLE: [false, false],
    FIELD_GENDER: [false, false, false],
    FIELD_BIRTHDATE: null,
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

  updateValue(key, value) {
    // values[key] = value;
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
    if (genderValues.every((item) => item == false)) {
      errors[FIELD_GENDER] = 'field_gender_validation_empty';
      fails = true;
    }
    if (values[FIELD_BIRTHDATE] == null) {
      errors[FIELD_BIRTHDATE] = 'field_birthdate_validation_empty';
      fails = true;
    }

    notifyListeners();

    return fails;
  }

  signUp(context) async {
    try {
      var user = await CognitoService.signUp(
          values[FIELD_NAME], values[FIELD_EMAIL], values[FIELD_PASSWORD]);
      if (!user.userConfirmed) {
        isRegistered = true;
        selectedTab = 2;
      }
    } on CustomCognitoUsernameExistsException catch (e) {
      showError(context, 'Error creating account', e.cause,
          ERROR_VISUALIZATIONS_TYPE.dialog);
    }
  }
}
