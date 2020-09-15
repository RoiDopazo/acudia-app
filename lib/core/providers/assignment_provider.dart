import 'package:flutter/material.dart';

class AssignmentsProvider with ChangeNotifier {
  int selectedTab = 0;
  DateTime fromDate;
  DateTime toDate;
  TimeOfDay startHour;
  TimeOfDay endHour;
  int fare;

  moveToConfig() {
    selectedTab = 1;
    notifyListeners();
  }

  showHospList() {
    selectedTab = 0;
    notifyListeners();
  }

  updateFromDate(DateTime fromDateParam) {
    fromDate = fromDateParam;
    notifyListeners();
  }

  updateToDate(DateTime toDateParam) {
    toDate = toDateParam;
    notifyListeners();
  }

  updateStartHour(TimeOfDay startDateParam) {
    startHour = startDateParam;
    notifyListeners();
  }

  updateEndHour(TimeOfDay endHourParam) {
    endHour = endHourParam;
    notifyListeners();
  }

  updateFare(int fareParam) {
    fare = fareParam;
    notifyListeners();
  }

  cleanup() {
    selectedTab = 0;
    fromDate = null;
    toDate = null;
    startHour = null;
    endHour = null;
    fare = null;
  }
}
