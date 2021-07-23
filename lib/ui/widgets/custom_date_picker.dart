import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ColumnType { month, year }

class CustomDatePicker extends StatefulWidget {
  final DateTime today = DateTime.now();

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime datePickerDate = DateTime.now();
  late int _selectedMonthIndex = widget.today.month;
  late int _selectedYearIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 232,
      child: Stack(alignment: AlignmentDirectional.centerStart, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _datePickerColumn(forType: ColumnType.month),
            _datePickerColumn(forType: ColumnType.year),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 10),
          child: Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(color: Color(0xffbe5713), shape: BoxShape.circle),
          ),
        )
      ]),
    );
  }

  List<int> get _datePickerYears {
    final List<int> years = [];
    for (int year = widget.today.year; year <= widget.today.year + 10; year++) {
      years.add(year);
    }
    for (int year = widget.today.year - 100; year < widget.today.year; year++) {
      years.add(year);
    }
    return years;
  }

  Map<int, String> get _datePickerMonths {
    // TODO: Localization
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
    // TODO: null safety - wtf monthsMap is type of Map<int, String>
    return {for (var key in keysOrder) key: monthsMap[key] as String};
  }

  Widget _datePickerColumn({required ColumnType forType}) {
    final items = forType == ColumnType.month ? _datePickerMonths : _datePickerYears.asMap();

    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.5,
      child: ListWheelScrollView.useDelegate(
        physics: const FixedExtentScrollPhysics(),
        itemExtent: 36,
        childDelegate: ListWheelChildLoopingListDelegate(
            children: items.keys
                .map((index) => _setListItem(
                    forType: forType, index: index, text: items[index].toString(), items: items))
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

  Widget _setListItem(
      {required int index,
      required ColumnType forType,
      required String text,
      required Map<int, Object> items}) {
    final int selectedIndex =
        forType == ColumnType.month ? _selectedMonthIndex : _selectedYearIndex;

    final List<int> keys = items.keys.toList();
    keys.sort();

    final bool firstOrLastCoupleInList =
        (((selectedIndex == keys.last) && (index == keys.first || index == keys.first + 1)) ||
                (selectedIndex == keys.last - 1) && (index == keys.first)) ||
            (((selectedIndex == keys.first) && (index == keys.last || index == keys.last - 1)) ||
                (selectedIndex == keys.first + 1) && (index == keys.last));

    double opacityValue = 0.2;

    if (index == selectedIndex) {
      opacityValue = 1;
    } else if (((index <= selectedIndex + 2) && (index > selectedIndex)) ||
        ((index >= selectedIndex - 2) && (index < selectedIndex)) ||
        firstOrLastCoupleInList) {
      opacityValue = 0.5;
    }

    return Opacity(
        opacity: opacityValue,
        child: Text(
          text,
          style:
              const TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Color(0xFF000000)),
        ));
  }

  void _selectedItemHandle({required ColumnType forType, required Map items, required int value}) {
    switch (forType) {
      case ColumnType.month:
        datePickerDate = DateTime(datePickerDate.year, value);
        break;
      case ColumnType.year:
        datePickerDate = DateTime(items[value] as int, datePickerDate.month);
        break;
    }
    // TODO: Handle selected date
    print("$forType change to value $datePickerDate");
  }
}
