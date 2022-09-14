import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/datepicker_helpers.dart';
import 'package:loono/l10n/ext.dart';

const _itemHeight = 40.0;

enum ColumnType { day, month, year }

class DatePicker extends StatefulWidget {
  DatePicker({
    Key? key,
    required this.valueChanged,
    required this.defaultDate,
    required this.minDate,
    required this.maxDate,
    this.yearEnabled = true,
    this.monthEnabled = true,
    this.dayEnabled = true,
    this.filled = false,
  }) : super(key: key);

  final DateTime today = DateTime.now();
  final ValueChanged<DateTime> valueChanged;
  final DateTime defaultDate;
  final DateTime minDate;
  final DateTime maxDate;
  final bool yearEnabled;
  final bool monthEnabled;
  final bool dayEnabled;
  final bool filled;

  @override
  DatePickerState createState() => DatePickerState();

  int getDefaultYear() {
    return defaultDate.year;
  }

  int getDefaultMonth() {
    return defaultDate.month;
  }

  int getDefaultDay() {
    return defaultDate.day;
  }

  int getMinYear() {
    return minDate.year;
  }

  int getMaxYear() {
    return maxDate.year;
  }

  int getMinMonth() {
    return minDate.month;
  }

  int getMaxMonth() {
    return maxDate.month;
  }

  int getMinDay() {
    return minDate.day;
  }

  int getMaxDay() {
    return maxDate.day;
  }
}

class DatePickerState extends State<DatePicker> {
  late int _selectedDayIndex = -1;
  late int _selectedMonthIndex = -1;
  late int _selectedYearIndex = -1;
  late DateTime datePickerDate = widget.defaultDate;

  final FixedExtentScrollController _dayController =
      FixedExtentScrollController();
  final FixedExtentScrollController _monthController =
      FixedExtentScrollController();
  final FixedExtentScrollController _yearController =
      FixedExtentScrollController();

  List<int> get _datePickerYears {
    final defaultYear = widget.getDefaultYear();
    final minYear = widget.getMinYear();
    final maxYear = widget.getMaxYear();
    assert(defaultYear >= minYear && defaultYear <= maxYear);

    final diff = maxYear - minYear;
    final years = <int>[];
    for (var i = 0; i <= diff; i++) {
      final year = defaultYear + i <= maxYear
          ? defaultYear + i
          : defaultYear - (diff - i + 1);
      years.add(year);
    }
    return years;
  }

  Map<int, String> get _datePickerMonths {
    final monthsMap = <int, String>{
      DateTime.january: context.l10n.month_january,
      DateTime.february: context.l10n.month_february,
      DateTime.march: context.l10n.month_march,
      DateTime.april: context.l10n.month_april,
      DateTime.may: context.l10n.month_may,
      DateTime.june: context.l10n.month_june,
      DateTime.july: context.l10n.month_july,
      DateTime.august: context.l10n.month_august,
      DateTime.september: context.l10n.month_september,
      DateTime.october: context.l10n.month_october,
      DateTime.november: context.l10n.month_november,
      DateTime.december: context.l10n.month_december,
    };
    final defaultMonth = widget.getDefaultMonth();
    assert(monthsMap.containsKey(defaultMonth));

    final keysOrder = List<int>.generate(DateTime.monthsPerYear, (index) {
      if (DateTime.monthsPerYear - index < defaultMonth) {
        return index - (DateTime.monthsPerYear - defaultMonth);
      } else {
        return defaultMonth + index;
      }
    });
    final months = <int, String>{};
    for(final key in keysOrder){
      months[key] = monthsMap[key]!;
    }
    return months;
  }

  List<int> get _datePickerDays {
    final daysInMonth =
        DateTime(datePickerDate.year, _selectedMonthIndex + 1, 0).day;

    final days = [for (var i = 1; i <= daysInMonth; i += 1) i];

    return days;
  }

  @override
  void initState() {
    widget.valueChanged(datePickerDate);
    super.initState();
  }

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedYearIndex == -1) {
      log('unselected year');
      _selectedYearIndex = _datePickerYears.indexOf(widget.defaultDate.year);
    }
    if (_selectedMonthIndex == -1) {
      _selectedMonthIndex = _datePickerMonths.keys.first;//.toList().indexOf(widget.getDefaultMonth());

      log('unselected month set to $_selectedMonthIndex');
    }
    if (_selectedDayIndex == -1) {
      log('unselected day');
      _selectedDayIndex = _datePickerDays.indexOf(widget.defaultDate.day);
    }
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
              _datePickerColumn(
                forType: ColumnType.day,
                items: _getAvailableDays().asMap(),
                selectedIndex: _selectedDayIndex,
              ),
              _datePickerColumn(
                forType: ColumnType.month,
                items: _getAvailableMonths(),
                selectedIndex: _selectedMonthIndex,
              ),
              _datePickerColumn(
                forType: ColumnType.year,
                items: _datePickerYears.asMap(),
                selectedIndex: _selectedYearIndex,
              ),
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

  ///removes moths over [maxDate] and under [minDate]
  Map<int, String> _getAvailableMonths() {
    if (_isMinYear()) {
      final months = <int, String>{};

      var monthIndex = _datePickerMonths.length - 1;
      var month = _datePickerMonths[monthIndex];
      while (monthIndex >= widget.minDate.month) {
        if (month != null) {
          months[monthIndex] = month;
        }

        monthIndex--;
        if (monthIndex < 0) break;
        month = _datePickerMonths[monthIndex];
      }

      return months;
    } else if (_isMaxYear()) {
      final months = <int, String>{};

      var monthIndex = 0;
      var month = _datePickerMonths[monthIndex];
      while (monthIndex <= widget.maxDate.month) {
        if (month != null) {
          months[monthIndex] = month;
        }

        monthIndex++;
        if (monthIndex > _datePickerMonths.length - 1) break;

        month = _datePickerMonths[monthIndex];
      }

      return months;
    }
    return _datePickerMonths;
  }

  List<int> _getAvailableDays() {
    log('_getAvailableDays()');
    log('selected month: ${_getSelectedMonth()}');
    log('is min month: ${_isMinMonth()}');
    log('is max month: ${_isMaxMonth()}');
    if (_isMinMonth()) {
      final days = <int>[];

      var day = _datePickerDays.last;
      while (day >= widget.minDate.day && day >= _datePickerDays.first) {
        days.add(day);
        day--;
      }

      return days;
    } else if (_isMaxMonth()) {
      final days = <int>[];

      var day = 1;
      while (day <= widget.maxDate.day && day <= _datePickerDays.last) {
        days.add(day);
        log(day.toString());
        day++;
      }
      return days;
    }
    return _datePickerDays;
  }

  bool _isMinYear() {
    return _getSelectedYear() == widget.minDate.year;
  }

  bool _isMaxYear() {
    return _getSelectedYear() == widget.maxDate.year;
  }

  bool _isMinMonth() {
    return _isMinYear() && _getSelectedMonth() == widget.minDate.month;
  }

  bool _isMaxMonth() {
    return _isMaxYear() && _getSelectedMonth() == widget.maxDate.month;
  }

  int _getSelectedYear() {
    return _datePickerYears[_selectedYearIndex];
  }

  int? _getSelectedMonth() {
    final keys = _datePickerMonths.keys.toList();
    log('selected month index: ${_selectedMonthIndex.toString()}');
    log('selected month index of: ${keys.indexOf(_selectedMonthIndex)}');
    return keys[keys.indexOf(_selectedMonthIndex)];
  }

  int _getSelectedDay() {
    return _datePickerDays[_selectedDayIndex];
  }

  Widget _datePickerColumn({
    required ColumnType forType,
    required Map<int, Object> items,
    required int selectedIndex,
  }) {
    return SizedBox(
      key: Key('customDatePicker_${forType.name}'),
      width: MediaQuery.of(context).size.width / (widget.dayEnabled ? 4 : 3),
      child: ListWheelScrollView.useDelegate(
        physics: const FixedExtentScrollPhysics(),
        controller: forType == ColumnType.day
            ? _dayController
            : forType == ColumnType.year
                ? _yearController
                : _monthController,
        itemExtent: _itemHeight,
        childDelegate: ListWheelChildLoopingListDelegate(
          children: items.keys.map(
            (index) {
              return setListItem(
                index: index,
                text: items[index].toString(),
                items: items,
                selectedIndex: selectedIndex,
              );
            },
          ).toList(),
        ),
        onSelectedItemChanged: (index) {
          _selectedItemHandle(
            forType: forType,
            items: items,
            value: items.keys.elementAt(index),
          );

          setState(() {
            forType == ColumnType.day
                ? _selectedDayIndex = index
                : forType == ColumnType.month
                    ? _selectedMonthIndex = items.keys.elementAt(index)
                    : _selectedYearIndex = index;
          });
        },
      ),
    );
  }

  void _selectedItemHandle(
      {required ColumnType forType, required Map items, required int value}) {
    /// handle different month lengths
    if (forType == ColumnType.month || forType == ColumnType.year) {
      /// compensate for leap years
      final daysInMonth = forType == ColumnType.month
          ? DateTime(datePickerDate.year, value + 1, 0).day
          : DateTime(items[value] as int, datePickerDate.month + 1, 0).day;

      /// jump to maximal possible day
      _dayController.jumpToItem(_selectedDayIndex.clamp(0, daysInMonth));
      if (_selectedDayIndex > daysInMonth - 1) {
        _dayController.jumpToItem(daysInMonth - 1);
        setState(() {
          _selectedDayIndex = daysInMonth - 1;
        });
      }
    }

    switch (forType) {
      case ColumnType.day:
        datePickerDate = DateTime(
          datePickerDate.year,
          datePickerDate.month,
          items[value] as int,
        );
        break;
      case ColumnType.month:
        datePickerDate =
            DateTime(datePickerDate.year, value, datePickerDate.day);
        break;
      case ColumnType.year:
        datePickerDate = DateTime(
          items[value] as int,
          datePickerDate.month,
          datePickerDate.day,
        );
        break;
    }
    widget.valueChanged(datePickerDate);
  }
}
