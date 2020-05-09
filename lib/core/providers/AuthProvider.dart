import 'package:acudia/core/aws.dart';
import 'package:acudia/core/google.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/user.birthday.read',
    'https://www.googleapis.com/auth/userinfo.profile',
  ]);

  doLogin() async {
    final googleSignInAuthentication = await signInWithGoogle();
    print(googleSignInAuthentication);
    final credentials = new Credentials(
      'eu-west-1:2656d5c4-c95d-4a4e-9ffc-584b0d97d9cc',
      'eu-west-1_pI6G9Yvog',
      '61hus629iapedbilpgk438qup5',
      googleSignInAuthentication.idToken,
      'accounts.google.com',
    );

    final api =
        Api('http://localhost:8000', '/flutter', 'eu-west-1', credentials);

    final result = await api.post({});

    print(result.body);
    // print('doLogin');
    // final GoogleSignInAccount googleSignInAccount =
    //     await _googleSignIn.signIn();

    // final GoogleSignInAuthentication googleSignInAuthentication =
    //     await googleSignInAccount.authentication;

    // print(googleSignInAuthentication.accessToken);
    // print(googleSignInAuthentication.idToken);
  }
}
