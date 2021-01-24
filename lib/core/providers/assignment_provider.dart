import 'package:acudia/core/entity/assignment_entity.dart';
import 'package:acudia/utils/constants.dart';
import 'package:flutter/material.dart';

class AssignmentsProvider with ChangeNotifier {
  int selectedTab = 0;
  bool isEditting = false;
  Assignment assignment = new Assignment();
  Function refetch;
  RangeValues rangeValues = RangeValues(minFare, maxFare);

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
    if (assignment.to != null && fromDateParam.difference(assignment.to).inDays > 0) {
      assignment.to = null;
    }
    assignment.from = fromDateParam;
    notifyListeners();
  }

  updateToDate(DateTime toDateParam) {
    if (assignment.from != null && toDateParam.difference(assignment.from).inDays < 0) {
      assignment.from = null;
    }
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

  updateRangeValues(RangeValues rangeValuesParam) {
    rangeValues = rangeValuesParam;
    notifyListeners();
  }

  cleanup() {
    selectedTab = 0;
    isEditting = false;
    assignment = new Assignment();
    rangeValues = RangeValues(minFare, maxFare);
  }

  resetFilterValues() {
    assignment = new Assignment();
    assignment.from = new DateTime.now();
    rangeValues = RangeValues(minFare, maxFare);
  }
}
