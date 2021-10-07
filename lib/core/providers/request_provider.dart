import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/entity/profile_entity.dart';
import 'package:acudia/core/entity/request_entity.dart';
import 'package:acudia/core/providers/error_notifier_provider.dart';
import 'package:acudia/core/providers/profile_provider.dart';
import 'package:acudia/core/services/graphql_client.dart';
import 'package:acudia/core/services/requests/request_service.dart';
import 'package:acudia/routes.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:load/load.dart';
import 'package:provider/provider.dart';

class RequestProvider with ChangeNotifier {
  double rating = 0.0;
  String comment;
  bool hasChange = false;

  setRating(double ratingParam) {
    this.rating = ratingParam;
    this.hasChange = true;
    notifyListeners();
  }

  setComment(String commentParam) {
    this.comment = commentParam;
  }

  finishRequest(BuildContext context, Request request) async {
    Profile clientProfile = Provider.of<ProfileProvider>(context).profile;

    try {
      showLoadingDialog();
      await graphQLClient.value.mutate(
        MutationOptions(documentNode: gql(GRAPHQL_FINISH_REQUEST), variables: {
          "PK": request.PK,
          "SK": request.SK,
          "author": "${clientProfile.name} ${clientProfile.secondName}",
          "comment": this.comment,
          "rating": this.rating
        }),
      );
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.MAIN, (Route<dynamic> route) => false);
      hideLoadingDialog();
    } catch (err) {
      hideLoadingDialog();
      return showError(context, translate(context, 'error_unexpected'), translate(context, 'error_try_again_later'),
          ERROR_VISUALIZATIONS_TYPE.dialog);
    }
  }

  removeRequest(BuildContext context, Request request) async {
    try {
      showLoadingDialog();
      await graphQLClient.value.mutate(
        MutationOptions(documentNode: gql(GRAPHQL_REMOVE_REQUEST), variables: {"PK": request.PK, "SK": request.SK}),
      );
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.MAIN, (Route<dynamic> route) => false);
      hideLoadingDialog();
    } catch (err) {
      hideLoadingDialog();
      return showError(context, translate(context, 'error_unexpected'), translate(context, 'error_try_again_later'),
          ERROR_VISUALIZATIONS_TYPE.dialog);
    }
  }

  reset() {
    rating = 0.0;
    hasChange = false;
    comment = null;
    notifyListeners();
  }
}
