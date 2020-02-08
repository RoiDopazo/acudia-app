import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/user.birthday.read',
    'https://www.googleapis.com/auth/userinfo.profile',
  ]);

  doLogin() async {
    print('doLogin');
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    print(googleSignInAuthentication.accessToken);
    print(googleSignInAuthentication.idToken);
  }
}
