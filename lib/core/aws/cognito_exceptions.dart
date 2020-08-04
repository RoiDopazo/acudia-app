class CustomCognitoUsernameExistsException implements Exception {
  String cause;
  CustomCognitoUsernameExistsException(this.cause);
}

class CustonCognitoEmailVerificationException implements Exception {
  String cause;
  CustonCognitoEmailVerificationException(this.cause);
}
