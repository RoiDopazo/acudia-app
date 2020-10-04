import 'package:flutter/material.dart';

// ignore_for_file: non_constant_identifier_names

class AssignmentItem {
  DateTime from;
  DateTime to;
  TimeOfDay startHour;
  TimeOfDay endHour;
  int fare;
  List<bool> days;

  AssignmentItem(
      {this.from, this.to, this.startHour, this.endHour, this.fare, this.days});

  factory AssignmentItem.fromJson(Map<String, dynamic> json) {
    return AssignmentItem(
      from: DateTime.parse(json["from"]),
      to: DateTime.parse(json["to"]),
      startHour: new TimeOfDay(
          hour: (json["startHour"] / 3600).truncate(),
          minute: ((json['startHour'] % 3600) / 60).truncate()),
      endHour: new TimeOfDay(
          hour: (json["endHour"] / 3600).truncate(),
          minute: ((json['endHour'] % 3600) / 60).truncate()),
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
