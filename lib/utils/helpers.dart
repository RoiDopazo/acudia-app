import 'package:acudia/core/entity/assignment_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String normalizeTime(time) {
  String timeString = time.toString();

  if (time < 10) {
    timeString = '0$timeString';
  }
  return timeString;
}

String capitalize(String s) {
  if (s.length > 0) {
    return s[0].toUpperCase() + s.substring(1);
  }
  return '';
}

int calculateAge(DateTime birthDate) {
  if (birthDate == null) {
    return 0;
  }
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}

final DateFormat dateFormat = DateFormat('yMMMMd');

double timeOfDayToDouble(TimeOfDay time) {
  return time.hour + time.minute / 60.0;
}

int isDayAvailable(DateTime date, List<Assignment> assignments, TimeOfDay startHour, TimeOfDay endHour) {
  int result = 0;

  for (Assignment assig in assignments) {
    if (date.isBefore(assig.to) && date.isAfter(assig.from)) {
      result = 1;
      if (timeOfDayToDouble(startHour) >= timeOfDayToDouble(assig.startHour) &&
          timeOfDayToDouble(endHour) <= timeOfDayToDouble(assig.endHour)) {
        result = 2;
      }
    }
  }
  return result;
}

double getTotalPrice(DateTime startDate, DateTime endDate, List<Assignment> assignments, double duration) {
  double price = 0.0;
  DateTime date = startDate;

  while (date.isBefore(endDate) || date.isAtSameMomentAs(endDate)) {
    Assignment assig =
        assignments.firstWhere((assig) => date.isBefore(assig.to) && date.isAfter(assig.from), orElse: () => null);
    date = date.add(new Duration(days: 1));
    price += assig.fare * duration;
  }

  return double.parse(price.toStringAsFixed(2));
}
