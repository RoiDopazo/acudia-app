// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Assignment {
  String PK;
  String SK;
  String assignmentId;
  String hospId;
  String hospName;
  String hospProvince;
  DateTime from;
  DateTime to;
  TimeOfDay startHour;
  TimeOfDay endHour;
  double fare;
  List<bool> days;
  int createdAt;
  int updatedAt;

  Assignment(
      {this.PK,
      this.SK,
      this.assignmentId,
      this.hospId,
      this.hospName,
      this.hospProvince,
      this.from,
      this.to,
      this.startHour,
      this.endHour,
      this.fare,
      this.days,
      this.createdAt,
      this.updatedAt});

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      PK: json['PK'],
      SK: json['SK'],
      assignmentId: json['SK'].toString().substring(json['SK'].toString().indexOf('#') + 1),
      hospId: json['hospId'],
      hospName: json['hospName'],
      hospProvince: json['hospProvince'],
      from: DateTime.parse(json["from"]),
      to: DateTime.parse(json["to"]),
      startHour: new TimeOfDay(
          hour: (json["startHour"] / 3600).truncate(), minute: ((json['startHour'] % 3600) / 60).truncate()),
      endHour:
          new TimeOfDay(hour: (json["endHour"] / 3600).truncate(), minute: ((json['endHour'] % 3600) / 60).truncate()),
      fare: json['fare'] != null ? json['fare'].toDouble() : 0.0,
      days: json['days'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  static List<Assignment> fromJsonList(List<dynamic> jsonList) {
    List<Assignment> assignmentList = [];

    jsonList.forEach((element) {
      assignmentList.add(Assignment.fromJson(element));
    });

    return assignmentList;
  }

  Map<String, dynamic> toJson() {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");

    return {
      "hospId": this.hospId,
      "assignmentId": this.assignmentId,
      "hospName": this.hospName,
      "hospProvince": this.hospProvince,
      "from": dateFormat.format(this.from),
      "to": dateFormat.format(this.to),
      "startHour": this.startHour.hour * 3600 + this.startHour.minute * 60,
      "endHour": this.endHour.hour * 3600 + this.endHour.minute * 60,
      "fare": this.fare
    };
  }
}
