import 'package:acudia/core/entity/assignment_entity.dart';
import 'package:acudia/core/entity/hospital_entity.dart';
import 'package:acudia/core/entity/profile_entity.dart';
import 'package:acudia/core/entity/request_entity.dart';
import 'package:acudia/core/providers/app_provider.dart';
import 'package:acudia/core/providers/profile_provider.dart';
import 'package:acudia/core/services/graphql_client.dart';
import 'package:acudia/core/services/requests/request_service.dart';
import 'package:acudia/routes.dart';
import 'package:flutter/material.dart';
import 'package:acudia/utils/helpers.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:load/load.dart';
import 'package:provider/provider.dart';

class AvailabilityProvider with ChangeNotifier {
  TimeOfDay startHour;
  TimeOfDay endHour;
  DateTime startDate;
  DateTime endDate;
  double price;

  setRangeHours(TimeOfDay startHourProp, TimeOfDay endHourProp, List<Assignment> assignments, List<Request> requests) {
    startHour = startHourProp;
    endHour = endHourProp;

    if (startDate != null && endDate != null && assignments != null) {
      setSelectedDates(startDate, endDate, assignments, requests);
    }
    notifyListeners();
  }

  setSelectedDates(DateTime date1, DateTime date2, List<Assignment> assignments, List<Request> requests) {
    List<int> checks = [];
    DateTime computedDate2 = date2 != null ? date2 : date1;
    if (date1 != null) {
      DateTime rangeDate = date1;
      while (rangeDate.isBefore(computedDate2) || rangeDate.isAtSameMomentAs(computedDate2)) {
        checks.add(isDayAvailable(rangeDate, assignments, requests, startHour, endHour));
        rangeDate = rangeDate.add(new Duration(days: 1));
      }

      if (checks.every((value) => value == 2)) {
        price = getTotalPrice(
            date1, computedDate2, assignments, (timeOfDayToDouble(endHour) - timeOfDayToDouble(startHour).abs()));
      } else {
        price = null;
      }
    }
    startDate = date1;
    endDate = computedDate2;
    notifyListeners();
  }

  confirmAvailability(BuildContext context, Profile acudier, Hospital hospital) async {
    Profile client = Provider.of<ProfileProvider>(context).profile;
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    showLoadingDialog();

    await graphQLClient.value.mutate(
      MutationOptions(documentNode: gql(GRAPHQL_CREATE_REQUEST), variables: {
        "acudier": acudier.PK,
        "acudierName": '${acudier.name} ${acudier.secondName}',
        "acudierPhoto": acudier.photoUrl,
        "clientName": '${client.name} ${client.secondName}',
        "clientPhoto": client.photoUrl,
        "hospId": hospital.codCNH,
        "hospName": hospital.name,
        "from": dateFormat.format(startDate),
        "to": dateFormat.format(endDate),
        "startHour": startHour.hour * 3600 + startHour.minute * 60,
        "endHour": endHour.hour * 3600 + endHour.minute * 60,
        "price": price
      }),
    );

    Provider.of<AppProvider>(context).setSelectedTab(context, 1);

    hideLoadingDialog();
    Navigator.pushNamedAndRemoveUntil(context, Routes.MAIN, (route) => false);
  }

  reset() {
    price = null;
    startDate = null;
    endDate = null;
    notifyListeners();
  }
}
