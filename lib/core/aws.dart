import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Credentials {
  final CognitoCredentials _cognitoCredentials;
  final String _token;
  final String _authenticator;

  Credentials(
      String identityPoolId, String userPoolId, String clientId, this._token,
      [this._authenticator])
      : _cognitoCredentials = new CognitoCredentials(
            identityPoolId, new CognitoUserPool(userPoolId, clientId));

  Future<CognitoCredentials> get cognitoCredentials async {
    await _cognitoCredentials.getAwsCredentials(_token, _authenticator);
    return _cognitoCredentials;
  }
}

class Api {
  final String endpoint;
  final String path;
  final String region;
  final Credentials credentials;

  Api(this.endpoint, this.path, this.region, this.credentials);

  final userPool =
      new CognitoUserPool('eu-west-1_pI6G9Yvog', '4pcnthaokr2vsbtkl9mtj2ki94');

  final cognitoCredentials2 = new CognitoCredentials(
      'eu-west-1:2656d5c4-c95d-4a4e-9ffc-584b0d97d9cc',
      new CognitoUserPool('eu-west-1_pI6G9Yvog', '4pcnthaokr2vsbtkl9mtj2ki94'));

  post(String body) async {
    final cognitoUser = new CognitoUser('Roi2', userPool);

    final authDetails =
        new AuthenticationDetails(username: 'Roi2', password: 'Aaaa1234!');
    CognitoUserSession session;
    try {
      session = await cognitoUser.authenticateUser(authDetails);
    } on CognitoUserNewPasswordRequiredException catch (e) {
      try {
        if (e.requiredAttributes.isEmpty) {
          // No attribute hast to be set
          session =
              await cognitoUser.sendNewPasswordRequiredAnswer("Aaaa1234!");
        } else {
          // All attributes from the e.requiredAttributes has to be set.
          print(e.requiredAttributes);
          // For example obtain and set the name attribute.
          var attributes = {
            "name": "Roiiii",
            "gender": 'male',
            "profile": 'aa',
            "picture": 'ee',
            // "phone_number": "+34663700943",
            "middle_name": 'Roi',
            "name": "Rooiiii",
          };
          session = await cognitoUser.sendNewPasswordRequiredAnswer(
              "Aaaa1234!", attributes);
        }
      } catch (err) {
        print(err);
      }
    } catch (e) {
      print(e);
    }

    // await cognitoCredentials2
    //     .getAwsCredentials(session.getIdToken().getJwtToken());

    // CognitoCredentials cognitoCredentials =
    //     await credentials.cognitoCredentials;
    // final awsSigV4Client = new AwsSigV4Client(
    //   cognitoCredentials2.accessKeyId,
    //   cognitoCredentials2.secretAccessKey,
    //   endpoint,
    //   serviceName: 'appsync',
    //   sessionToken: cognitoCredentials2.sessionToken,
    //   region: 'eu-west-1',
    // );
    // final signedRequest = new SigV4Request(
    //   awsSigV4Client,
    //   method: 'POST',
    //   path: path,
    //   // headers: new Map<String, String>.from({'header-1': 'one', 'header-2': 'two'}),
    //   // queryParams: new Map<String, String>.from({'tracking': 'x123'}),
    //   body: body,
    // );

    // final signedRequest = new SigV4Request(awsSigV4Client,
    //     method: 'POST',
    //     path: '/graphql',
    //     headers: new Map<String, String>.from(
    //         {'Content-Type': 'application/graphql; charset=utf-8'}),
    //     body: new Map<String, String>.from(
    //         {'operationName': 'listClients', 'query': body}));

    // http.Response response;

    // try {
    //   response = await http.post(signedRequest.url,
    //       headers: signedRequest.headers, body: signedRequest.body);
    // } catch (error) {
    //   print('error');
    //   print(error);
    // }

    final body = {
      'operationName': 'listClients',
      'query': '''query listClients {
    listClients {
        items {
            id
            name
        }
    }
}''',
    };
    http.Response response;
    try {
      response = await http.post(
        '$endpoint/graphql',
        headers: {
          'Authorization': session.getAccessToken().getJwtToken(),
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );
    } catch (e) {
      print(e);
    }

    print(response);

    return response;
  }
}
