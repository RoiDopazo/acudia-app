import 'package:flutter/material.dart';

// ignore_for_file: non_constant_identifier_names

class AssignmentItem {
  final DateTime from;
  final DateTime to;
  final TimeOfDay startHour;
  final TimeOfDay endHour;
  final int fare;
  final List<bool> days;

  AssignmentItem(
      {this.from, this.to, this.startHour, this.endHour, this.fare, this.days});

  factory AssignmentItem.fromJson(Map<String, dynamic> json) {
    return AssignmentItem(
      from: DateTime.parse(json["from"]),
      to: DateTime.parse(json["to"]),
      startHour: new TimeOfDay(
          hour: (json["startHour"] / 60).truncate(), minute: json['startHour'] % 60),
      endHour: new TimeOfDay(
          hour: (json["endHour"] / 60).truncate(),
          minute: json['endHour'] % 60),
      fare: json['fare'],
      days: json['days'],
    );
  }

  static List<AssignmentItem> fromJsonList(List<dynamic> jsonList) {
    List<AssignmentItem> assignmentItemList = [];

    jsonList.forEach((element) {
      assignmentItemList.add(AssignmentItem.fromJson(element));
    });

    return assignmentItemList;
  }
}
