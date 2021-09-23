import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';

enum ColumnType { month, year }

class CustomDatePicker extends StatefulWidget {
  final DateTime today = DateTime.now();
  final ValueChanged<DateTime> valueChanged;
  final int yearsBeforeActual;
  final int yearsOverActual;
  final int? defaultMonth;
  final int? defaultYear;

  CustomDatePicker({
    Key? key,
    required this.valueChanged,
    this.yearsBeforeActual = 100,
    this.yearsOverActual = 10,
    this.defaultMonth,
    this.defaultYear,
  }) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late int _selectedMonthIndex = widget.defaultMonth ?? widget.today.month;
  late int _selectedYearIndex = 0;
  late DateTime datePickerDate = DateTime(
    widget.defaultYear ?? widget.today.year,
    _selectedMonthIndex,
    widget.today.day,
  );

  @override
  void initState() {
    widget.valueChanged(datePickerDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Stack(alignment: AlignmentDirectional.centerStart, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _datePickerColumn(forType: ColumnType.month),
            _datePickerColumn(forType: ColumnType.year),
          ],
        ),
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(color: LoonoColors.primary, shape: BoxShape.circle),
        )
      ]),
    );
  }

  List<int> get _datePickerYears {
    final defaultYear = widget.defaultYear ?? widget.today.year;
    final minYear = widget.today.year - widget.yearsBeforeActual;
    final maxYear = widget.today.year + widget.yearsOverActual;
    assert(defaultYear >= minYear && defaultYear <= maxYear);

    final diff = maxYear - minYear;
    final List<int> years = [];
    for (int i = 0; i <= diff; i++) {
      final year = defaultYear + i <= maxYear ? defaultYear + i : defaultYear - (diff - i + 1);
      years.add(year);
    }

    return years;
  }

  Map<int, String> get _datePickerMonths {
    final Map<int, String> monthsMap = {
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
    final int defaultMonth = widget.defaultMonth ?? widget.today.month;
    assert(monthsMap.containsKey(defaultMonth));

    final List<int> keysOrder = List<int>.generate(DateTime.monthsPerYear, (index) {
      if (DateTime.monthsPerYear - index < defaultMonth) {
        return index - (DateTime.monthsPerYear - defaultMonth);
      } else {
        return defaultMonth + index;
      }
    });

    return {for (var key in keysOrder) key: monthsMap[key]!};
  }

  Widget _datePickerColumn({required ColumnType forType}) {
    final items = forType == ColumnType.month ? _datePickerMonths : _datePickerYears.asMap();

    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: ListWheelScrollView.useDelegate(
        physics: const FixedExtentScrollPhysics(),
        itemExtent: 40,
        childDelegate: ListWheelChildLoopingListDelegate(
            children: items.keys
                .map((index) =>
                    _setListItem(forType: forType, index: index, text: items[index].toString(), items: items))
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

  Widget _setListItem({
    required int index,
    required ColumnType forType,
    required String text,
    required Map<int, Object> items,
  }) {
    final int selectedIndex = forType == ColumnType.month ? _selectedMonthIndex : _selectedYearIndex;

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
      case ColumnType.month:
        datePickerDate = DateTime(datePickerDate.year, value);
        break;
      case ColumnType.year:
        datePickerDate = DateTime(items[value] as int, datePickerDate.month);
        break;
    }
    widget.valueChanged(datePickerDate);
  }
}
