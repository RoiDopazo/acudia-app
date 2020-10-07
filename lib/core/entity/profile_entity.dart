// ignore_for_file: non_constant_identifier_names

import 'package:acudia/utils/constants.dart';

class Profile {
  final String PK;
  final String SK;
  final String name;
  final String secondName;
  final String email;
  final USER_ROLES role;
  final isAcudier;
  final USER_GENDER gender;
  final DateTime birthDate;
  final String photoUrl;
  final int createdAt;
  final int updatedAt;

  Profile({
    this.PK,
    this.SK,
    this.name,
    this.secondName,
    this.email,
    this.role,
    this.isAcudier,
    this.gender,
    this.birthDate,
    this.photoUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    String role = json["PK"].toString().substring(0, json["PK"].toString().indexOf('#'));

    return Profile(
      PK: json["PK"],
      SK: json["SK"],
      name: json["name"],
      secondName: json["secondName"],
      email: json["email"],
      role: USER_ROLES.values.firstWhere((e) => e.toString() == 'USER_ROLES.' + role),
      isAcudier: USER_ROLES.values.firstWhere((e) => e.toString() == 'USER_ROLES.' + role) == USER_ROLES.ACUDIER,
      gender: json["genre"] != null && json["genre"] != ''
          ? USER_GENDER.values.firstWhere((e) => e.toString() == 'USER_GENDER.' + json["genre"])
          : null,
      birthDate: json["birthDate"] != null && json["birthDate"] != '' ? DateTime.parse(json["birthDate"]) : null,
      photoUrl: json["photoUrl"] != null && json["photoUrl"] != '' ? json["photoUrl"] : null,
      createdAt: json["createdAt"] != null && json["createdAt"] != '' ? json["createdAt"] : null,
      updatedAt: json["updatedAt"] != null && json["updatedAt"] != '' ? json["updatedAt"] : null,
    );
  }
}
