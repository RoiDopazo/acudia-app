import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/aws/cognito_exceptions.dart';
import 'package:acudia/core/aws/cognito_service.dart';
import 'package:acudia/core/providers/error_notifier_provider.dart';
import 'package:acudia/core/providers/profile_provider.dart';
import 'package:acudia/core/services/acudiers/acudiers_service.dart';
import 'package:acudia/core/services/clients/clients_service.dart';
import 'package:acudia/core/services/graphql_client.dart';
import 'package:acudia/routes.dart';
import 'package:acudia/utils/constants.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:cloudinary_client/cloudinary_client.dart';
import 'package:cloudinary_client/models/CloudinaryResponse.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:load/load.dart';
import 'package:provider/provider.dart';

const FIELD_NAME = 'name';
const FIELD_SECOND_NAME = 'secondName';
const FIELD_EMAIL = 'email';
const FIELD_PASSWORD = 'password';
const FIELD_PASSWORD_CONFIRM = 'password_confirm';
const FIELD_GENDER = 'gender';
const FIELD_ROLE = 'role';
const FIELD_BIRTHDATE = 'birthdate';
const FIELD_IMAGE = 'image';

class SignUpProvider with ChangeNotifier {
  CloudinaryClient _cloudinaryClient =
      new CloudinaryClient(CLOUDINARY_API_KEY, CLOUDINARY_API_SECRET, CLOUDINARY_API_NAME);

  bool showLogin = false;
  int selectedTab = 0;
  bool isRegistered = false;
  String verificationCode = '';
  final values = {
    FIELD_NAME: 'Ruben',
    FIELD_SECOND_NAME: 'Castro',
    // FIELD_EMAIL: 'rdopazobucket@gmail.com',
    FIELD_EMAIL: 'roidopazo@gmail.com',
    FIELD_PASSWORD: 'Aaaa1234',
    FIELD_PASSWORD_CONFIRM: 'Aaaa1234',
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

  resetValues() {
    // values[FIELD_EMAIL] = '';
    // values[FIELD_PASSWORD] = '';
    selectedTab = 0;
    notifyListeners();
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
      showLoadingDialog();
      CognitoUser cognitoUser = await CognitoService.login(values[FIELD_EMAIL], values[FIELD_PASSWORD]);
      hideLoadingDialog();
      Provider.of<ProfileProvider>(context, listen: false).getProfileData(context, cognitoUser);
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.MAIN, (Route<dynamic> route) => false);
    } catch (error) {
      // TODO: Handle error
      print(error);
      hideLoadingDialog();
    }
  }

  signUp(context) async {
    try {
      showLoadingDialog();
      List<bool> genderList = values[FIELD_GENDER];
      List<bool> roleList = values[FIELD_ROLE];
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      String photoUrl;

      String gender =
          roleList.indexOf(true) == 0 ? null : USER_GENDER.values[genderList.indexOf(true)].toString().split('.').last;

      String birthDate = roleList.indexOf(true) == 0 ? null : formatter.format(values[FIELD_BIRTHDATE]);

      // Upload image to cloudinary
      if (values[FIELD_IMAGE] != null) {
        CloudinaryResponse response = await _cloudinaryClient.uploadImage(values[FIELD_IMAGE]);
        if (response != null) {
          photoUrl = response.secure_url;
        }
      }

      CognitoUserPoolData user = await CognitoService.signUp(
          values[FIELD_NAME],
          values[FIELD_SECOND_NAME],
          values[FIELD_EMAIL],
          values[FIELD_PASSWORD],
          USER_ROLES.values[roleList.indexOf(true)].toString().split('.').last,
          gender,
          birthDate,
          photoUrl);

      hideLoadingDialog();
      if (!user.userConfirmed) {
        isRegistered = true;
        selectedTab = 2;
        notifyListeners();
      }
      // ignore: unused_catch_clause
    } on CustomCognitoUsernameExistsException catch (e) {
      hideLoadingDialog();
      showError(context, translate(context, 'error_creating_account'),
          translate(context, 'error_creating_account_username_exists'), ERROR_VISUALIZATIONS_TYPE.dialog);
    }
  }

  verifyEmail(context, email, code) async {
    try {
      showLoadingDialog();
      await CognitoService.verifyEmail(email, code);
      CognitoUser cognitoUser = await CognitoService.login(email, values[FIELD_PASSWORD]);
      Provider.of<ProfileProvider>(context, listen: false).getProfileData(context, cognitoUser);

      bool isAcudier;
      const validAtt = [
        'name',
        'custom:secondName',
        'email',
        'custom:role',
        'custom:gender',
        'custom:birthDate',
        'custom:photoUrl'
      ];

      List<CognitoUserAttribute> attributes = await CognitoService.getUserAttributes(cognitoUser);

      Map<String, String> variables = {};

      attributes.forEach((e) {
        if (validAtt.contains(e.name)) {
          if (e.value != null) {
            if (e.name == 'custom:role') {
              isAcudier = e.value == USER_ROLES.values[1].toString().split('.').last;
            }
            String name = e.name.indexOf(':') != -1 ? e.name.substring(e.name.indexOf(':') + 1) : e.name;
            variables[name] = e.value;
          }
        }
      });

      await graphQLClient.value.mutate(
        MutationOptions(
            documentNode: gql(isAcudier ? GRAPHQL_CREATE_ACUDIER_MUTATION : GRAPHQL_CREATE_CLIENT_MUTATION),
            variables: variables),
      );
      hideLoadingDialog();
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.MAIN, (Route<dynamic> route) => false);
    } catch (error) {
      hideLoadingDialog();
      return showError(context, translate(context, 'error_unexpected'), translate(context, 'error_try_again_later'),
          ERROR_VISUALIZATIONS_TYPE.dialog);
    }
  }

  resendVerificationCode(context, email) async {
    try {
      showLoadingDialog();
      await CognitoService.resendVerificationCode(email);
      hideLoadingDialog();
    } catch (error) {
      hideLoadingDialog();
      if (error.statusCode == 400 && error.code == 'LimitExceededException') {
        return showError(context, translate(context, 'error_limit_exceeded'),
            translate(context, 'error_try_again_later'), ERROR_VISUALIZATIONS_TYPE.dialog);
      }
      return showError(context, translate(context, 'error_unexpected'), translate(context, 'error_try_again_later'),
          ERROR_VISUALIZATIONS_TYPE.dialog);
    }
  }
}
