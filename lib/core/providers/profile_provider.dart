import 'package:acudia/core/aws/cognito_service.dart';
import 'package:acudia/core/entity/profile_entity.dart';
import 'package:acudia/core/services/acudiers/acudiers_service.dart';
import 'package:acudia/core/services/clients/clients_service.dart';
import 'package:acudia/core/services/graphql_client.dart';
import 'package:acudia/utils/constants.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProfileProvider with ChangeNotifier {
  bool loading = true;
  Profile profile;

  getProfileData(CognitoUser cognitoUser) async {
    if (!loading) {
      loading = true;
      notifyListeners();
    }

    List<CognitoUserAttribute> userAttributes =
        await CognitoService.getUserAttributes(cognitoUser);
    if (userAttributes != null && userAttributes.length != 0) {
      CognitoUserAttribute role =
          userAttributes.singleWhere((att) => att.getName() == 'custom:role');
      CognitoUserAttribute email =
          userAttributes.singleWhere((att) => att.getName() == 'email');

      bool isAcudier = role.getValue().toString() ==
          USER_ROLES.ACUDIER.toString().split('.')[1];

      var result = await graphQLClient.value.query(
        QueryOptions(
            documentNode: gql(isAcudier
                ? GRAPHQL_GET_ACUDIER_BY_ID
                : GRAPHQL_GET_CLIENT_BY_ID),
            variables: {
              "email": email.getValue(),
            }),
      );
      if (isAcudier) {
        profile = Profile.fromJson(result.data['getAcudierByID']);
      } else {
        profile = Profile.fromJson(result.data['getClientByID']);
      }

      loading = false;
      notifyListeners();
    }
  }
}
