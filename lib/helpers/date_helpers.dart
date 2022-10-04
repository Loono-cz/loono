import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);

  /// .inDays does not work here (https://stackoverflow.com/questions/52713115/flutter-find-the-number-of-days-between-two-dates/67679455#67679455)
  return (to.difference(from).inHours / 24).round();
}

int transformYearToMonth(String str) => (int.parse(str.replaceAll(RegExp(r'[^0-9]'), '')) * 12);
int transformMonthToYear(num month) => (month < 12 ? month : month / 12).round();

int transformInterval(BuildContext context, String str) {
  final splitedString = str.split(' ');
  final number = splitedString[0];
  final desc = splitedString[1];
  return desc == context.l10n.years ? transformYearToMonth(number) : int.parse(number);
}
