import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/constants.dart';

enum ColumnType { month, year }

class CustomDatePicker extends StatefulWidget {
  final DateTime today = DateTime.now();
  final ValueChanged valueChanged;
  final int yearsBeforeActual;
  final int yearsOverActual;

  CustomDatePicker(
      {Key? key,
      required this.valueChanged,
      this.yearsBeforeActual = 100,
      this.yearsOverActual = 10})
      : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime datePickerDate = DateTime.now();
  late int _selectedMonthIndex = widget.today.month;
  late int _selectedYearIndex = 0;

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
    return List<int>.generate(widget.yearsBeforeActual + widget.yearsOverActual + 1, (index) {
      if (index > widget.yearsOverActual) {
        return (widget.today.year - widget.yearsBeforeActual - widget.yearsOverActual) + index - 1;
      } else {
        return widget.today.year + index;
      }
    });
  }

  Map<int, String> get _datePickerMonths {
    final Map<int, String> monthsMap = {
      DateTime.january: context.l10n.custom_date_picker_jan,
      DateTime.february: context.l10n.custom_date_picker_feb,
      DateTime.march: context.l10n.custom_date_picker_mar,
      DateTime.april: context.l10n.custom_date_picker_apr,
      DateTime.may: context.l10n.custom_date_picker_may,
      DateTime.june: context.l10n.custom_date_picker_jun,
      DateTime.july: context.l10n.custom_date_picker_jul,
      DateTime.august: context.l10n.custom_date_picker_aug,
      DateTime.september: context.l10n.custom_date_picker_sep,
      DateTime.october: context.l10n.custom_date_picker_oct,
      DateTime.november: context.l10n.custom_date_picker_nov,
      DateTime.december: context.l10n.custom_date_picker_dec,
    };

    final List<int> keysOrder = List<int>.generate(DateTime.monthsPerYear, (index) {
      if (DateTime.monthsPerYear - index < widget.today.month) {
        return index - (DateTime.monthsPerYear - widget.today.month);
      } else {
        return widget.today.month + index;
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
