import 'package:acudia/core/aws/cognito_exceptions.dart';
import 'package:acudia/utils/constants.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';

class Credentials {
  CognitoUserPool _cognitoUserPool;

  Credentials._privateConstructor() {
    _cognitoUserPool = new CognitoUserPool(USER_POOL_ID, USER_POOL_CLIENT_ID);
  }

  static final Credentials _instance = Credentials._privateConstructor();

  static CognitoUserPool get cognitoUserPool {
    return _instance._cognitoUserPool;
  }
}

class CognitoService {
  static signUp(String name, String email, String password) async {
    CognitoUserPool userPool = Credentials.cognitoUserPool;
    final userAttributes = [
      new AttributeArg(name: 'name', value: name),
      new AttributeArg(name: 'email', value: email),
    ];

    try {
      return await userPool.signUp(email, password,
          userAttributes: userAttributes);
    } on CognitoClientException catch (e) {
      if (e.code == "UsernameExistsException") {
        throw new CustomCognitoUsernameExistsException(e.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  static verifyEmail(String email, String code) async {
    CognitoUserPool userPool = Credentials.cognitoUserPool;

    final cognitoUser = new CognitoUser(email, userPool);

    await cognitoUser.confirmRegistration(code);
  }

  static resendVerificationCode(email) async {
    CognitoUserPool userPool = Credentials.cognitoUserPool;

    final cognitoUser = new CognitoUser(email, userPool);
    await cognitoUser.resendConfirmationCode();
  }
}
