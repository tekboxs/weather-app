class DateHandler {
  static final List<String> _weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  static String getWeekDay() {
    int weekDayInt = DateTime.now().weekday;

    return _weekDays[weekDayInt - 1];
  }
}
