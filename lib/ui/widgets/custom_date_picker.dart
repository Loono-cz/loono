import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ColumnType { month, year }

class CustomDatePicker extends StatefulWidget {
  final double customHeight;
  final DateTime today = DateTime.now();

  CustomDatePicker({this.customHeight = 232});

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime datePickerDate = DateTime.now();
  int _selectedMonthIndex = 0;
  int _selectedYearIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.customHeight,
      child: Row(
        children: [
          const Spacer(),
          // TODO: add dot asset
          _datePickerColumn(forType: ColumnType.month),
          _datePickerColumn(forType: ColumnType.year),
          const Spacer()
        ],
      ),
    );
  }

  List<int> _getDatePickerYears() {
    final List<int> years = [];
    for (int year = widget.today.year; year <= widget.today.year + 10; year++) {
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
    for (int month = widget.today.month; month <= DateTime.monthsPerYear; month++) {
      keysOrder.add(month);
    }
    for (int month = DateTime.january; month < widget.today.month; month++) {
      keysOrder.add(month);
    }
    // TODO: null safety
    return {for (var key in keysOrder) key: monthsMap[key] as String};
  }

  Widget _datePickerColumn({required ColumnType forType}) {
    final items =
        forType == ColumnType.month ? _getDatePickerMonths() : _getDatePickerYears().asMap();

    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.5,
      child: ListWheelScrollView.useDelegate(
        physics: const FixedExtentScrollPhysics(),
        itemExtent: 36,
        childDelegate: ListWheelChildLoopingListDelegate(
            children: items.keys
                .map((index) =>
                    _setListItem(forType: forType, index: index, text: items[index].toString()))
                .toList()),
        onSelectedItemChanged: (index) {
          _selectedItemHandle(forType: forType, items: items, value: items.keys.elementAt(index));
          setState(() {
            forType == ColumnType.month
                ? _selectedMonthIndex = items.keys.elementAt(index)
                : _selectedYearIndex = index;
          });
        },
      ),
    );
  }

  Widget _setListItem({required int index, required ColumnType forType, required String text}) {
    final int selectedIndex =
        forType == ColumnType.month ? _selectedMonthIndex : _selectedYearIndex;

    if (index == selectedIndex) {
      return Opacity(
          opacity: 1,
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF000000)),
          ));
    } else if (((index <= selectedIndex + 2) && (index > selectedIndex)) ||
        (index >= selectedIndex - 2) && (index < selectedIndex)) {
      return Opacity(
          opacity: 0.6,
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.w400, color: Color(0xFF000000)),
          ));
    } else {
      return Opacity(
          opacity: 0.2,
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.w400, color: Color(0xFF000000)),
          ));
    }
  }

  void _selectedItemHandle({required ColumnType forType, required Map items, required int value}) {
    switch (forType) {
      case ColumnType.month:
        datePickerDate = DateTime(datePickerDate.year, value);
        print("month change $datePickerDate");
        print(_selectedMonthIndex);
        break;
      case ColumnType.year:
        datePickerDate = DateTime(items[value] as int, datePickerDate.month);
        print("year change $datePickerDate");
        break;
    }
  }
}
