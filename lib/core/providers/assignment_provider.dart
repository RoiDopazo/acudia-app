import 'package:acudia/core/entity/assignment_item_entity.dart';
import 'package:flutter/material.dart';

class AssignmentsProvider with ChangeNotifier {
  int selectedTab = 0;
  bool isEditting = false;
  AssignmentItem assignmentItem;

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
    assignmentItem.from = fromDateParam;
    notifyListeners();
  }

  updateToDate(DateTime toDateParam) {
    assignmentItem.to = toDateParam;
    notifyListeners();
  }

  updateStartHour(TimeOfDay startDateParam) {
    assignmentItem.startHour = startDateParam;
    notifyListeners();
  }

  updateEndHour(TimeOfDay endHourParam) {
    assignmentItem.endHour = endHourParam;
    notifyListeners();
  }

  updateFare(int fareParam) {
    assignmentItem.fare = fareParam;
    notifyListeners();
  }

  setAssignmentItem(AssignmentItem assignmentItemParam) {
    assignmentItem = assignmentItemParam;
    notifyListeners();
  }

  cleanup() {
    selectedTab = 0;
    isEditting = false;
    assignmentItem = new AssignmentItem();
  }
}
