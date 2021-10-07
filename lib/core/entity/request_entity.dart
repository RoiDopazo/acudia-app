// ignore_for_file: non_constant_identifier_names
import 'package:acudia/utils/constants.dart';
import 'package:flutter/material.dart';

class Request {
  final String PK;
  final String SK;
  final REQUEST_STATUS status;
  final String acudier;
  final String acudierName;
  final String acudierPhoto;
  final String client;
  final String clientName;
  final String clientPhoto;
  final DateTime from;
  final DateTime to;
  final TimeOfDay startHour;
  final TimeOfDay endHour;
  final String hospId;
  final String hospName;
  final double price;
  final double createdAt;
  final double updatedAt;
  final bool hasStarted;
  final bool hasFinished;

  Request(
      {this.PK,
      this.SK,
      this.status,
      this.acudier,
      this.acudierName,
      this.acudierPhoto,
      this.client,
      this.clientName,
      this.clientPhoto,
      this.from,
      this.to,
      this.startHour,
      this.endHour,
      this.price,
      this.hospId,
      this.hospName,
      this.createdAt,
      this.updatedAt,
      this.hasStarted,
      this.hasFinished});

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      PK: json["PK"],
      SK: json["SK"],
      status: REQUEST_STATUS.values.firstWhere((e) => e.toString() == 'REQUEST_STATUS.' + json['status']),
      acudier: json['acudier'],
      acudierName: json['acudierName'],
      acudierPhoto: json['acudierPhoto'],
      client: json['client'],
      clientName: json['clientName'],
      clientPhoto: json['clientPhoto'],
      from: DateTime.parse(json["from"]),
      to: DateTime.parse(json["to"]),
      startHour: new TimeOfDay(
          hour: (json["startHour"] / 3600).truncate(), minute: ((json['startHour'] % 3600) / 60).truncate()),
      endHour:
          new TimeOfDay(hour: (json["endHour"] / 3600).truncate(), minute: ((json['endHour'] % 3600) / 60).truncate()),
      price: json['price'] != null ? json['price'].toDouble() : 0.0,
      hospId: json['hospId'],
      hospName: json['hospName'],
      hasStarted: json['hasStarted'] != null ? json['hasStarted'] : false,
      hasFinished: json['hasFinished'] != null ? json['hasFinished'] : false,
      createdAt: json['createdAt'].toDouble(),
      updatedAt: json['updatedAt'].toDouble(),
    );
  }

  static List<Request> fromJsonList(List<dynamic> jsonList) {
    List<Request> requestList = [];

    jsonList.forEach((element) {
      requestList.add(Request.fromJson(element));
    });

    return requestList;
  }
}
