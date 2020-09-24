// ignore_for_file: non_constant_identifier_names

import 'assignment_item_entity.dart';

class Assignment {
  final String PK;
  final String SK;
  final String hospId;
  final String hospName;
  final String hospProvince;
  final List<AssignmentItem> itemList;
  final int createdAt;

  Assignment(
      {this.PK,
      this.SK,
      this.hospId,
      this.hospName,
      this.hospProvince,
      this.itemList,
      this.createdAt});

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      PK: json['PK'],
      SK: json['SK'],
      hospId: json['hospId'],
      hospName: json['hospName'],
      hospProvince: json['hospProvince'],
      itemList: AssignmentItem.fromJsonList(json['itemList']),
      createdAt: json['createdAt'],
    );
  }

  static List<Assignment> fromJsonList(List<dynamic> jsonList) {
    List<Assignment> assignmentList = [];

    jsonList.forEach((element) {
      assignmentList.add(Assignment.fromJson(element));
    });

    return assignmentList;
  }
}
