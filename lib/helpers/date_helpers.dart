int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);

  /// .inDays does not work here (https://stackoverflow.com/questions/52713115/flutter-find-the-number-of-days-between-two-dates/67679455#67679455)
  return (to.difference(from).inHours / 24).round();
}

int transformYearToMonth(String str) => (int.parse(str.replaceAll(RegExp(r'\d+'), '')) * 12);

num transformMonthToYear(num year) => year < 12 ? year : year / 12;
