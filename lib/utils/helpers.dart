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
