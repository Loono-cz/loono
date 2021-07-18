import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ColumnType { month, year }

class CustomDatePicker extends StatefulWidget {
  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();

  final DateTime today = DateTime.now();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
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
    for (int year = 1900; year <= widget.today.year + 10; year++) {
      years.add(year);
    }
    return years;
  }

  Map<int, String> _getDatePickerMonths() {
    return {
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
  }

  Widget _datePickerColumn({required ColumnType forType}) {
    final items =
        forType == ColumnType.month ? _getDatePickerMonths() : _getDatePickerYears().asMap();

    return SizedBox(
      width: 160,
      child: ListWheelScrollView.useDelegate(
        overAndUnderCenterOpacity: 0.3,
        physics: const FixedExtentScrollPhysics(),
        itemExtent: 31,
        perspective: 0.001,
        childDelegate: ListWheelChildLoopingListDelegate(
            children: items.keys
                .map(
                  (index) => Text(
                    items[index].toString(),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                )
                .toList()),
        onSelectedItemChanged: (index) => () {
          if (forType == ColumnType.month) {
            print("mesic $index");
          } else {
            print("rok $index");
          }
        },
      ),
    );
  }
}
