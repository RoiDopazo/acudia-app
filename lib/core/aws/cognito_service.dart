import 'package:acudia/core/aws/cognito_exceptions.dart';
import 'package:acudia/core/storage-service.dart';
import 'package:acudia/utils/constants.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';

class Credentials {
  static Credentials _instance;
  factory Credentials() => _instance ??= new Credentials._();
  Credentials._();

  final CognitoUserPool _cognitoUserPool =
      new CognitoUserPool(USER_POOL_ID, USER_POOL_CLIENT_ID);

  Storage _storage;

  void init(prefs) {
    _storage = new Storage(prefs);
  }

  CognitoUserPool getUserPool() {
    _cognitoUserPool.storage = _storage;
    return _cognitoUserPool;
  }
}

class CognitoService {
  static getUserData() async {
    CognitoUserPool userPool = Credentials().getUserPool();

    final user = await userPool.getCurrentUser();
    if (user != null) {
      final session = await user.getSession();
      return session;
    }
    return null;
  }

  static signUp(String name, String email, String password) async {
    CognitoUserPool userPool = Credentials().getUserPool();
    final userAttributes = [
      new AttributeArg(name: 'name', value: name),
      new AttributeArg(name: 'email', value: email),
    ];

    try {
      CognitoUserPoolData user = await userPool.signUp(email, password,
          userAttributes: userAttributes);
      return user;
    } on CognitoClientException catch (e) {
      if (e.code == "UsernameExistsException") {
        throw new CustomCognitoUsernameExistsException(e.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  static login(String email, String password) async {
    CognitoUserPool userPool = Credentials().getUserPool();
    final cognitoUser =
        new CognitoUser(email, userPool, storage: userPool.storage);
    final authDetails =
        new AuthenticationDetails(username: email, password: password);
    CognitoUserSession session;
    try {
      session = await cognitoUser.authenticateUser(authDetails);
      return session;
    } catch (e) {
      print(e);
    }
  }

  static verifyEmail(String email, String code) async {
    CognitoUserPool userPool = Credentials().getUserPool();

    final cognitoUser = new CognitoUser(email, userPool);

    await cognitoUser.confirmRegistration(code);
  }

  static resendVerificationCode(email) async {
    CognitoUserPool userPool = Credentials().getUserPool();

    final cognitoUser = new CognitoUser(email, userPool);
    await cognitoUser.resendConfirmationCode();
  }

  static logout() async {
    CognitoUserPool userPool = Credentials().getUserPool();

    final user = await userPool.getCurrentUser();
    user.signOut();
  }
}
