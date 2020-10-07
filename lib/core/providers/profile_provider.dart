import 'package:acudia/core/aws/cognito_service.dart';
import 'package:acudia/core/entity/profile_entity.dart';
import 'package:acudia/core/services/graphql_client.dart';
import 'package:acudia/core/services/profile/profile_service.dart';
import 'package:acudia/utils/constants.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProfileProvider with ChangeNotifier {
  bool loading = true;
  Profile profile;

  getProfileData(BuildContext context, CognitoUser cognitoUser) async {
    if (!loading) {
      loading = true;
      notifyListeners();
    }

    CognitoUser cUser = cognitoUser;
    if (cognitoUser == null) {
      Map<String, dynamic> cognitoUserData = await CognitoService.getUserData();
      cUser = cognitoUserData["user"];
    }

    try {
      List<CognitoUserAttribute> userAttributes = await CognitoService.getUserAttributes(cUser);
      if (userAttributes != null && userAttributes.length != 0) {
        CognitoUserAttribute role = userAttributes.singleWhere((att) => att.getName() == 'custom:role');

        bool isAcudier = role.getValue().toString() == USER_ROLES.ACUDIER.toString().split('.')[1];

        var result = await graphQLClient.value.query(
          QueryOptions(documentNode: gql(GRAPHQL_GET_PROFILE_QUERY), variables: {
            "role":
                isAcudier ? USER_ROLES.ACUDIER.toString().split('.')[1] : USER_ROLES.CLIENT.toString().split('.')[1],
          }),
        );
        profile = Profile.fromJson(result.data['getProfile']);

        loading = false;
        notifyListeners();
      }
    } catch (error) {
      loading = false;
      profile = null;
      notifyListeners();
    }
  }
}
