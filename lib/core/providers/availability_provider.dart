import 'package:acudia/core/entity/assignment_entity.dart';
import 'package:acudia/core/entity/request_entity.dart';
import 'package:flutter/material.dart';
import 'package:acudia/utils/helpers.dart';

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

  reset() {
    price = null;
    startDate = null;
    endDate = null;
    notifyListeners();
  }
}
