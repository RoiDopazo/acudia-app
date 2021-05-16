import 'package:flutter/material.dart';

class AvailabilityProvider with ChangeNotifier {
  TimeOfDay startHour;
  TimeOfDay endHour;

  setStartHour(TimeOfDay startHourProp) {
    startHour = startHourProp;
    notifyListeners();
  }

  setEndHour(TimeOfDay endHourProp) {
    endHour = endHourProp;
    notifyListeners();
  }
}
