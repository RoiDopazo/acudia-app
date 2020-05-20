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
      '4pcnthaokr2vsbtkl9mtj2ki94',
      googleSignInAuthentication.idToken,
      'accounts.google.com',
    );

    final api = Api(
        'https://f425dk466jdddb6lvbnbykf75m.appsync-api.eu-west-1.amazonaws.com',
        '/graphql',
        'eu-west-1',
        credentials);

    String query = """
query listClients {
    listClients {
        items {
            id
            name
        }
    }
}
""";

    final result = await api.post(query);

    print(result.body);
    // print('doLogin');
    // final GoogleSignInAccount googleSignInAccount =
    //     await _googleSignIn.signIn();

    // final GoogleSignInAuthentication googleSignInAuthentication =
    //     await googleSignInAccount.authentication;

    // print(googleSignInAuthentication.accessToken);
    // print(googleSignInAuthentication.idToken);

// eyJhbGciOiJSUzI1NiIsImtpZCI6Ijk2MGE3ZThlODM0MWVkNzUyZjEyYjE4NmZhMTI5NzMxZmUwYjA0YzAiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxMDk5MzM5ODA0OTgtdWNrNWkxYTlramo3Z25qdG03YmtiYjQxb2M3bjhibmguYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxMDk5MzM5ODA0OTgtdWNrNWkxYTlramo3Z25qdG03YmtiYjQxb2M3bjhibmguYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTM4NTc0MzYyMTU3NzU1ODYxMjEiLCJlbWFpbCI6InJvaWRvcGF6b0BnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiYXRfaGFzaCI6IldXcDhSdjRLbWJaZUYyT1d2d1p3RXciLCJub25jZSI6ImVxOVBkUmJ4Qmo2eUhhR3VjT3Y3QVAwRGtvLXVPblRPaG9xMlZYVktLT1UiLCJuYW1lIjoiUm9kcmlnbyBEb3Bhem8iLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDQuZ29vZ2xldXNlcmNvbnRlbnQuY29tLy05aHdfSXVVUF9lRS9BQUFBQUFBQUFBSS9BQUFBQUFBQUFBQS9BTVp1dWNsRUJURTE2dHpXeUFndk1DdjNfMlk4STVIY1BnL3M5Ni1jL3Bob3RvLmpwZyIsImdpdmVuX25hbWUiOiJSb2RyaWdvIiwiZmFtaWx5X25hbWUiOiJEb3Bhem8iLCJsb2NhbGUiOiJlcyIsImlhdCI6MTU4OTkwNTQ3MSwiZXhwIjoxNTg5OTA5MDcxfQ.K_1Zhvyj7cu1mje14g4KiANywbNNV-gZKbq2bN3covkvKaUfHKZjmpTp9FmO4UKP1wBDK3I-n2sjvMa2Ep40ZPk6AwASVXXOP34lnPGe54Y1lpfEMSppm8XRP5Pumk-XUinaOvPWSz2agnATETBucfyISwep-eK0yvHl7LZbodbYZ7rI63AR5HPKB5TiE5OcehYeU90WcaTzC9MtfQ92qcn5m9hjqs2RlRxQxsz4UMQdGWjFozgH6VpNloAgy9p4R5CBDnQMzAjJdSuMYF2zpPzrdJ9lLl7Rj5exXHL9cWGAVRc5LDD3H56Iqfq-fiRKrwCIxpeHsZi7ZygwfFstwg
  }
}
