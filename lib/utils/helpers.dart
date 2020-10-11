String normalizeTime(time) {
  String timeString = time.toString();

  if (time < 10) {
    timeString = '0$timeString';
  }
  return timeString;
}
