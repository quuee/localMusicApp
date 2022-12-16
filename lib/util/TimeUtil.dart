class TimeUtil {

  static String formatTime(int milliseconds) {
    int seconds = milliseconds ~/ 1000;
    int minute = seconds ~/ 60;
    int hour = minute ~/ 60;
    String strHour = hour == 0 ? '' : '$hour:';
    return "$strHour${getTimeString(minute % 60)}:${getTimeString(seconds % 60)}";
  }

  static String getTimeString(int value) {
    return value > 9 ? "$value" : "0$value";
  }
}
