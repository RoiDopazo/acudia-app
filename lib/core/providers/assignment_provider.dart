import 'package:acudia/core/entity/assignment_entity.dart';
import 'package:flutter/material.dart';

class AssignmentsProvider with ChangeNotifier {
  int selectedTab = 0;
  bool isEditting = false;
  Assignment assignment;
  Function refetch;

  moveToConfig(isEdittingParam) {
    if (isEdittingParam) {
      isEditting = true;
    }
    selectedTab = 1;
    notifyListeners();
  }

  showHospList() {
    selectedTab = 0;
    notifyListeners();
  }

  updateFromDate(DateTime fromDateParam) {
    assignment.from = fromDateParam;
    notifyListeners();
  }

  updateToDate(DateTime toDateParam) {
    assignment.to = toDateParam;
    notifyListeners();
  }

  updateStartHour(TimeOfDay startDateParam) {
    assignment.startHour = startDateParam;
    notifyListeners();
  }

  updateEndHour(TimeOfDay endHourParam) {
    assignment.endHour = endHourParam;
    notifyListeners();
  }

  updateFare(double fareParam) {
    assignment.fare = fareParam;
    notifyListeners();
  }

  setAssignment(Assignment assignmentParam) {
    assignment = assignmentParam;
    notifyListeners();
  }

  setRefetchFunc(Function refetchParam) {
    refetch = refetchParam;
  }

  cleanup() {
    selectedTab = 0;
    isEditting = false;
    assignment = new Assignment();
  }
}
