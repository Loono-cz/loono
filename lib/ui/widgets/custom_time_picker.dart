import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/datepicker_helpers.dart';

const _itemHeight = 40.0;

enum ColumnType { hour, minute }

class CustomTimePicker extends StatefulWidget {
  const CustomTimePicker({
    Key? key,
    required this.valueChanged,
    required this.defaultDate,
    this.defaultHour,
    this.defaultMinute,
    this.filled = false,
  }) : super(key: key);

  final ValueChanged<DateTime> valueChanged;
  final DateTime defaultDate;
  final int? defaultHour;
  final int? defaultMinute;
  final bool filled;

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late int _selectedHourIndex = 0;
  late int _selectedMinuteIndex = 0;
  late final int _defaultHour = widget.defaultHour ?? 9;
  late final int _defaultMinute = widget.defaultMinute ?? 0;

  late DateTime timePickerDate = widget.defaultDate;

  @override
  void initState() {
    widget.valueChanged(
      DateTime(
        timePickerDate.year,
        timePickerDate.month,
        timePickerDate.day,
        widget.defaultHour ?? 9,
        widget.defaultMinute ?? 0,
      ),
    );
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
              _timePickerColumn(forType: ColumnType.hour),
              _timePickerColumn(forType: ColumnType.minute),
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
    final hours = [for (var i = 0; i < 24; i += 1) i];

    final hoursShifted = hours.sublist(_defaultHour, 24) + hours.sublist(0, _defaultHour);

    return hoursShifted;
  }

  List<int> get _timePickerMinutes {
    final minutes = [for (var i = 0; i <= 55; i += 5) i];

    final roundedDefaultMinute = (_defaultMinute.clamp(0, 55) / 5).round() * 5;

    final minutesShifted = minutes.sublist(minutes.indexOf(roundedDefaultMinute), minutes.length) +
        minutes.sublist(0, minutes.indexOf(roundedDefaultMinute));

    return minutesShifted;
  }

  Widget _timePickerColumn({required ColumnType forType}) {
    final items =
        forType == ColumnType.hour ? _timePickerHours.asMap() : _timePickerMinutes.asMap();

    final selectedIndex = forType == ColumnType.hour ? _selectedHourIndex : _selectedMinuteIndex;

    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: ListWheelScrollView.useDelegate(
        physics: const FixedExtentScrollPhysics(),
        itemExtent: _itemHeight,
        childDelegate: ListWheelChildLoopingListDelegate(
          children: items.keys
              .map(
                (index) => setListItem(
                  index: index,
                  text: items[index].toString().padLeft(2, '0'),
                  items: items,
                  selectedIndex: selectedIndex,
                ),
              )
              .toList(),
        ),
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

  void _selectedItemHandle({required ColumnType forType, required Map items, required int value}) {
    switch (forType) {
      case ColumnType.hour:
        timePickerDate = DateTime(
          timePickerDate.year,
          timePickerDate.month,
          timePickerDate.day,
          items[value] as int,
          timePickerDate.minute,
        );
        break;
      case ColumnType.minute:
        timePickerDate = DateTime(
          timePickerDate.year,
          timePickerDate.month,
          timePickerDate.day,
          timePickerDate.hour,
          items[value] as int,
        );
        break;
    }
    widget.valueChanged(timePickerDate);
  }
}
