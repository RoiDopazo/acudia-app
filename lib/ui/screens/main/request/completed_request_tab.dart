import 'package:acudia/components/cards/request/completed_request_card.dart';
import 'package:acudia/core/entity/request_entity.dart';
import 'package:acudia/core/providers/profile_provider.dart';
import 'package:acudia/core/providers/request_provider.dart';
import 'package:acudia/core/services/requests/request_service.dart';
import 'package:acudia/routes.dart';
import 'package:acudia/ui/screens/main/request/details/request_details_args.dart';
import 'package:acudia/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class CompletedRequestTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    USER_ROLES role = Provider.of<ProfileProvider>(context).profile.role;
    bool isAcudier = role.toString().split('.')[1] == USER_ROLES.ACUDIER.toString().split('.')[1];

    return Query(
        options: QueryOptions(documentNode: gql(GRAPHQL_GET_MY_REQUESTS), variables: {
          "role": role.toString().split('.')[1],
          "status": REQUEST_STATUS.COMPLETED.toString().split('.')[1]
        }),
        builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Widget> widgetList = [];
          List<dynamic> responseJson = result.data["getMyRequests"]["completed"];

          responseJson.forEach((dynamic response) {
            Request request = Request.fromJson(response);

            onPress() {
              Provider.of<RequestProvider>(context).reset();
              Navigator.pushNamed(
                context,
                Routes.REQUEST_DETAILS,
                arguments: RequestDetailsArguments(request: request),
              );
            }

            Widget requestWidget = CompletedRequestCard(
                name: isAcudier ? request.clientName : request.acudierName,
                photoUrl: isAcudier ? request.clientPhoto : request.acudierPhoto,
                hospName: request.hospName,
                status: request.status,
                startDate: request.from,
                endDate: request.to,
                startHour: request.startHour,
                endHour: request.endHour,
                price: request.price,
                onPress: onPress);

            widgetList.add(requestWidget);
          });

          return SingleChildScrollView(child: Column(children: widgetList));
        });
  }
}
