import 'package:acudia/core/aws/cognito_exceptions.dart';
import 'package:acudia/core/aws/cognito_storage.dart';
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
  static Future<CognitoUserSession> getUserData() async {
    CognitoUserPool userPool = Credentials().getUserPool();

    final user = await userPool.getCurrentUser();
    if (user != null) {
      final session = await user.getSession();
      return session;
    }
    return null;
  }

  static Future<CognitoUserPoolData> signUp(
      String name,
      String secondName,
      String email,
      String password,
      String role,
      String gender,
      String birthDate,
      String photoUrl) async {
    CognitoUserPool userPool = Credentials().getUserPool();
    final userAttributes = [
      new AttributeArg(name: 'name', value: name),
      new AttributeArg(name: 'email', value: email),
      new AttributeArg(name: 'custom:secondName', value: secondName),
      new AttributeArg(name: 'custom:role', value: role),
    ];

    if (gender != null) {
      userAttributes
          .add(new AttributeArg(name: 'custom:gender', value: gender));
    }

    if (birthDate != null) {
      userAttributes
          .add(new AttributeArg(name: 'custom:birthDate', value: birthDate));
    }

    if (photoUrl != null) {
      userAttributes.add(
        new AttributeArg(name: 'custom:photoUrl', value: photoUrl),
      );
    }

    try {
      CognitoUserPoolData user = await userPool.signUp(email, password,
          userAttributes: userAttributes);
      return user;
    } on CognitoClientException catch (error) {
      if (error.code == "UsernameExistsException") {
        throw new CustomCognitoUsernameExistsException(error.message);
      }
    } catch (error) {
      rethrow;
    }
    return null;
  }

  static Future<CognitoUser> login(String email, String password) async {
    CognitoUserPool userPool = Credentials().getUserPool();
    final CognitoUser cognitoUser =
        new CognitoUser(email, userPool, storage: userPool.storage);
    final authDetails =
        new AuthenticationDetails(username: email, password: password);
    try {
      await cognitoUser.authenticateUser(authDetails);
      return cognitoUser;
    } catch (error) {
      print(error);
    }
    return null;
  }

  static Future<List<CognitoUserAttribute>> getUserAttributes(
      CognitoUser cognitoUser) async {
    List<CognitoUserAttribute> attributes;
    try {
      attributes = await cognitoUser.getUserAttributes();
      return attributes;
    } catch (error) {
      print(error);
    }
    return null;
  }

  static verifyEmail(String email, String code) async {
    CognitoUserPool userPool = Credentials().getUserPool();

    final cognitoUser =
        new CognitoUser(email, userPool, storage: userPool.storage);

    try {
      await cognitoUser.confirmRegistration(code);
    } catch (error) {
      // TODO: error handling
      print(error);
    }
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
