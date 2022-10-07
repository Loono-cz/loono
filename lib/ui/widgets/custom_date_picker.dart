import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/datepicker_helpers.dart';
import 'package:loono/l10n/ext.dart';

const _itemHeight = 40.0;

enum ColumnType { day, month, year }

class CustomDatePicker extends StatefulWidget {
  CustomDatePicker({
    Key? key,
    required this.valueChanged,
    this.yearsBeforeActual = 100,
    this.yearsOverActual = 10,
    this.defaultDay,
    this.defaultMonth,
    this.defaultYear,
    this.allowDays = false,
    this.filled = false,
  }) : super(key: key);

  final DateTime today = DateTime.now();
  final ValueChanged<DateTime> valueChanged;
  final int yearsBeforeActual;
  final int yearsOverActual;
  final int? defaultDay;
  final int? defaultMonth;
  final int? defaultYear;
  final bool allowDays;
  final bool filled;

  @override
  CustomDatePickerState createState() => CustomDatePickerState();
}

class CustomDatePickerState extends State<CustomDatePicker> {
  late int _selectedDayIndex = widget.defaultDay ?? 0;
  late int _selectedMonthIndex = widget.defaultMonth ?? widget.today.month;
  late int _selectedYearIndex = 0;
  late DateTime datePickerDate = DateTime(
    widget.defaultYear ?? widget.today.year,
    _selectedMonthIndex,
    _selectedDayIndex,
  );

  FixedExtentScrollController _dayController = FixedExtentScrollController();
  final FixedExtentScrollController _monthController = FixedExtentScrollController();
  final FixedExtentScrollController _yearController = FixedExtentScrollController();

  @override
  void initState() {
    widget.valueChanged(datePickerDate);
    super.initState();
    setState(() {
      _dayController = FixedExtentScrollController(
        initialItem: widget.defaultDay != null ? widget.defaultDay! : DateTime.now().day,
      );
    });
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
              if (widget.allowDays) _datePickerColumn(forType: ColumnType.day),
              _datePickerColumn(forType: ColumnType.month),
              _datePickerColumn(forType: ColumnType.year),
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

  List<int> get _datePickerYears {
    final defaultYear = widget.defaultYear ?? widget.today.year;
    final minYear = widget.today.year - widget.yearsBeforeActual;
    final maxYear = widget.today.year + widget.yearsOverActual;
    assert(defaultYear >= minYear && defaultYear <= maxYear);

    final diff = maxYear - minYear;
    final years = <int>[];
    for (var i = 0; i <= diff; i++) {
      final year = defaultYear + i <= maxYear ? defaultYear + i : defaultYear - (diff - i + 1);
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
    final defaultMonth = widget.defaultMonth ?? widget.today.month;
    assert(monthsMap.containsKey(defaultMonth));

    final keysOrder = List<int>.generate(DateTime.monthsPerYear, (index) {
      if (DateTime.monthsPerYear - index < defaultMonth) {
        return index - (DateTime.monthsPerYear - defaultMonth);
      } else {
        return defaultMonth + index;
      }
    });

    return {for (var key in keysOrder) key: monthsMap[key]!};
  }

  List<int> get _datePickerDays {
    final daysInMonth = DateTime(datePickerDate.year, _selectedMonthIndex + 1, 0).day;

    final days = [for (var i = 1; i <= daysInMonth; i += 1) i];

    return days;
  }

  Widget _datePickerColumn({required ColumnType forType}) {
    final items = forType == ColumnType.day
        ? _datePickerDays.asMap()
        : forType == ColumnType.month
            ? _datePickerMonths
            : _datePickerYears.asMap();

    final selectedIndex = forType == ColumnType.day
        ? _selectedDayIndex
        : forType == ColumnType.month
            ? _selectedMonthIndex
            : _selectedYearIndex;

    return SizedBox(
      key: Key('customDatePicker_${forType.name}'),
      width: MediaQuery.of(context).size.width / (widget.allowDays ? 4 : 3),
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
          _selectedItemHandle(forType: forType, items: items, value: items.keys.elementAt(index));

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

  void _selectedItemHandle({required ColumnType forType, required Map items, required int value}) {
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
        datePickerDate = DateTime(datePickerDate.year, datePickerDate.month, items[value] as int);
        break;
      case ColumnType.month:
        datePickerDate = DateTime(datePickerDate.year, value, datePickerDate.day);
        break;
      case ColumnType.year:
        datePickerDate = DateTime(items[value] as int, datePickerDate.month, datePickerDate.day);
        break;
    }
    widget.valueChanged(datePickerDate);
  }
}
