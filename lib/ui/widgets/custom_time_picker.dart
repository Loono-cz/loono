import 'package:flutter/material.dart';
import 'package:loono/constants.dart';

const _itemHeight = 40.0;

enum ColumnType { hour, minute }

class CustomTimePicker extends StatefulWidget {
  final ValueChanged<DateTime> valueChanged;
  final DateTime defaultDate;
  final int defaultHour;
  final bool filled;

  const CustomTimePicker({
    Key? key,
    required this.valueChanged,
    required this.defaultDate,
    this.defaultHour = 9,
    this.filled = false,
  }) : super(key: key);

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late int _selectedHourIndex = 0;
  late int _selectedMinuteIndex = 0;
  late final int _defaultHour = widget.defaultHour;
  late DateTime timePickerDate = widget.defaultDate;

  @override
  void initState() {
    widget.valueChanged(timePickerDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.32,
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          if (widget.filled)
            Container(
              width: double.infinity,
              height: _itemHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _datePickerColumn(forType: ColumnType.hour),
              _datePickerColumn(forType: ColumnType.minute),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: LoonoColors.primaryEnabled,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<int> get _timePickerHours {
    final hours = [for (var i = 1; i < 24; i += 1) i];

    final hoursShifted = hours.sublist(_defaultHour - 1, 23) + hours.sublist(0, _defaultHour - 1);

    return hoursShifted;
  }

  List<int> get _timePickerMinutes {
    final minutes = [for (var i = 0; i <= 55; i += 5) i];

    return minutes;
  }

  Widget _datePickerColumn({required ColumnType forType}) {
    final items =
        forType == ColumnType.hour ? _timePickerHours.asMap() : _timePickerMinutes.asMap();

    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: ListWheelScrollView.useDelegate(
        physics: const FixedExtentScrollPhysics(),
        itemExtent: _itemHeight,
        childDelegate: ListWheelChildLoopingListDelegate(
            children: items.keys
                .map((index) => _setListItem(
                    forType: forType,
                    index: index,
                    text: items[index].toString().padLeft(2, '0'),
                    items: items))
                .toList()),
        onSelectedItemChanged: (index) {
          _selectedItemHandle(forType: forType, items: items, value: items.keys.elementAt(index));

          setState(() {
            forType == ColumnType.hour
                ? _selectedHourIndex = items.keys.elementAt(index)
                : _selectedMinuteIndex = items.keys.elementAt(index);
          });
        },
      ),
    );
  }

  Widget _setListItem({
    required int index,
    required ColumnType forType,
    required String text,
    required Map<int, Object> items,
  }) {
    final int selectedIndex =
        forType == ColumnType.hour ? _selectedHourIndex : _selectedMinuteIndex;

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

    return Center(
      child: Opacity(
          opacity: opacityValue,
          child: Text(
            text,
            style: LoonoFonts.fontStyle,
          )),
    );
  }

  void _selectedItemHandle({required ColumnType forType, required Map items, required int value}) {
    switch (forType) {
      case ColumnType.hour:
        timePickerDate = DateTime(timePickerDate.year, timePickerDate.month, timePickerDate.day,
            items[value] as int, timePickerDate.minute);
        break;
      case ColumnType.minute:
        timePickerDate = DateTime(timePickerDate.year, timePickerDate.month, timePickerDate.day,
            timePickerDate.hour, items[value] as int);
        break;
    }
    widget.valueChanged(timePickerDate);
  }
}
