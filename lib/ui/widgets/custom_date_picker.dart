import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ColumnType { month, year }

class CustomDatePicker extends StatefulWidget {
  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();

  final DateTime today = DateTime.now();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime datePickerDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Row(
        children: [
          const Spacer(),
          _datePickerColumn(forType: ColumnType.month),
          _datePickerColumn(forType: ColumnType.year),
          const Spacer()
        ],
      ),
    );
  }

  List<int> _getDatePickerYears() {
    final List<int> years = [];
    for (int year = widget.today.year; year <= widget.today.year; year++) {
      years.add(year);
    }
    for (int year = widget.today.year - 100; year < widget.today.year; year++) {
      years.add(year);
    }
    return years;
  }

  Map<int, String> _getDatePickerMonths() {
    final Map<int, String> monthsMap = {
      DateTime.january: "Leden",
      DateTime.february: "Únor",
      DateTime.march: "Březen",
      DateTime.april: "Duben",
      DateTime.may: "Květen",
      DateTime.june: "Červen",
      DateTime.july: "Červenec",
      DateTime.august: "Srpen",
      DateTime.september: "Září",
      DateTime.october: "Říjen",
      DateTime.november: "Listopad",
      DateTime.december: "Prosinec",
    };
    final List<int> keysOrder = [];
    for (int month = widget.today.month; month <= 12; month++) {
      keysOrder.add(month);
    }
    for (int month = DateTime.january; month < widget.today.month; month++) {
      keysOrder.add(month);
    }
    return {for (var key in keysOrder) key: monthsMap[key] as String};
  }

  Widget _datePickerColumn({required ColumnType forType}) {
    final items =
        forType == ColumnType.month ? _getDatePickerMonths() : _getDatePickerYears().asMap();

    return SizedBox(
      width: 160,
      child: ListWheelScrollView.useDelegate(
        overAndUnderCenterOpacity: 0.3,
        physics: const FixedExtentScrollPhysics(),
        itemExtent: 36,
        childDelegate: ListWheelChildLoopingListDelegate(
            children: items.keys
                .map(
                  (index) => Text(
                    items[index].toString(),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                )
                .toList()),
        onSelectedItemChanged: (index) =>
            _selectedItemHandle(forType: forType, items: items, value: items.keys.elementAt(index)),
      ),
    );
  }

  TextStyle _setTextStyle({required String text}) {
    return TextStyle(fontSize: 24, fontWeight: FontWeight.w700);
  }

  void _selectedItemHandle({required ColumnType forType, required Map items, required int value}) {
    switch (forType) {
      case ColumnType.month:
        datePickerDate = DateTime(datePickerDate.year, value);
        print("month change $datePickerDate");
        break;
      case ColumnType.year:
        datePickerDate = DateTime(items[value] as int, datePickerDate.month);
        print("year change $datePickerDate");
        break;
    }
  }
}
