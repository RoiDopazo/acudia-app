import 'package:acudia/components/cards/request/incoming_request_card.dart';
import 'package:acudia/core/entity/request_entity.dart';
import 'package:acudia/core/providers/profile_provider.dart';
import 'package:acudia/core/providers/request_provider.dart';
import 'package:acudia/routes.dart';
import 'package:acudia/ui/screens/main/request/details/request_details_args.dart';
import 'package:acudia/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class IncomingRequestTab extends StatelessWidget {
  final List<dynamic> requests;

  const IncomingRequestTab({Key key, this.requests}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    USER_ROLES role = Provider.of<ProfileProvider>(context).profile.role;
    bool isAcudier = role.toString().split('.')[1] == USER_ROLES.ACUDIER.toString().split('.')[1];

    List<Widget> widgetList = [];

    requests.forEach((dynamic responseJson) {
      Request request = Request.fromJson(responseJson);
      Provider.of<RequestProvider>(context).reset();
      onPress() {
        Navigator.pushNamed(
          context,
          Routes.REQUEST_DETAILS,
          arguments: RequestDetailsArguments(request: request),
        );
      }

      Widget requestWidget = IncomingRequestCard(
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
  }
}
