import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly']);

  initLogin() {
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount account) async {
      if (account != null) {
        print('hello');
        // user logged
      } else {
        print('not logged');
        // user NOT logged
      }
    });
    _googleSignIn.signInSilently().whenComplete(() => print('when compleete'));
  }

  doLogin() async {
    print('doLogin');
    await _googleSignIn.signIn();
  }
}
