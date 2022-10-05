int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);

  /// .inDays does not work here (https://stackoverflow.com/questions/52713115/flutter-find-the-number-of-days-between-two-dates/67679455#67679455)
  return (to.difference(from).inHours / 24).round();
}

int transformYearToMonth(String str) => (int.parse(str.replaceAll(RegExp(r'[^0-9]'), '')) * 12);
int transformMonthToYear(num month) => (month < 12 ? month : month / 12).round();

DateTime alignDateTime(DateTime dt, Duration alignment, [bool roundUp = true]) {
  assert(alignment >= Duration.zero);
  if (alignment == Duration.zero) return dt;
  final correction = Duration(
    days: 0,
    minutes: alignment.inHours > 0
        ? dt.minute
        : alignment.inMinutes > 0
            ? dt.minute % alignment.inMinutes
            : 0,
  );
  if (correction == Duration.zero) return dt;
  final corrected = dt.subtract(correction);
  final result = roundUp ? corrected.add(alignment) : corrected;
  return result;
}
