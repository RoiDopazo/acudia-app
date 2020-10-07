import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore_for_file: non_constant_identifier_names

class AssignmentItem {
  DateTime from;
  DateTime to;
  TimeOfDay startHour;
  TimeOfDay endHour;
  int fare;
  List<bool> days;

  AssignmentItem({this.from, this.to, this.startHour, this.endHour, this.fare, this.days});

  factory AssignmentItem.fromJson(Map<String, dynamic> json) {
    return AssignmentItem(
      from: DateTime.parse(json["from"]),
      to: DateTime.parse(json["to"]),
      startHour: new TimeOfDay(
          hour: (json["startHour"] / 3600).truncate(), minute: ((json['startHour'] % 3600) / 60).truncate()),
      endHour:
          new TimeOfDay(hour: (json["endHour"] / 3600).truncate(), minute: ((json['endHour'] % 3600) / 60).truncate()),
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

  Map<String, dynamic> toJson() {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");

    return {
      "from": dateFormat.format(this.from),
      "to": dateFormat.format(this.to),
      "startHour": this.startHour.hour * 3600 + this.startHour.minute * 60,
      "endHour": this.endHour.hour * 3600 + this.endHour.minute * 60,
      "fare": this.fare
    };
  }
}
