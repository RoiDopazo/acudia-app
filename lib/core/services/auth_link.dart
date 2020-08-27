import 'dart:async';

import 'package:acudia/core/aws/cognito_service.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CustomAuthLink extends Link {
  CustomAuthLink()
      : super(
          request: (Operation operation, [NextLink forward]) {
            StreamController<FetchResult> controller;

            Future<void> onListen() async {
              try {
                Map<String, dynamic> userData =
                    await CognitoService.getUserData();
                CognitoUserSession userSession = userData["session"];

                String token = userSession.getAccessToken().getJwtToken();
                operation.setContext(<String, Map<String, String>>{
                  'headers': <String, String>{'Authorization': token}
                });
              } catch (error) {
                controller.addError(error);
              }

              await controller.addStream(forward(operation));
              await controller.close();
            }

            controller = StreamController<FetchResult>(onListen: onListen);

            return controller.stream;
          },
        );
}
