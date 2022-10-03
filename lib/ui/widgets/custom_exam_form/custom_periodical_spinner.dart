import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/datepicker_helpers.dart';
import 'package:loono/l10n/ext.dart';

const _itemHeight = 40.0;

enum FrequencyType { numbers, period }

final items = Period.values.asMap();

class CustomPeriodicalSpinner extends StatefulWidget {
  const CustomPeriodicalSpinner({
    super.key,
    required this.valueChanged,
  });
  final Function(String, Period) valueChanged;
  @override
  State<CustomPeriodicalSpinner> createState() => _CustomPeriodicalSpinnerState();
}

class _CustomPeriodicalSpinnerState extends State<CustomPeriodicalSpinner> {
  int _selectedFrequency = 0;
  int _selectedStringIndex = 0;

  var num = '1';
  int get value => int.parse(num);
  var period = Period.perMonth;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final finalInterval = _selectedStringIndex >= 1 ? 10 : 11;
    final monthNumbers =
        [for (var i = _selectedStringIndex == 1 ? 1 : 6; i <= finalInterval; i++) i].asMap();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: LoonoColors.primaryEnabled,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Text(context.l10n.custom_exam_once_per),
          _monthPickerColumn(monthNumbers),
          _frequencyPickerColumn(),
        ],
      ),
    );
  }

  Widget _monthPickerColumn(Map<int, int> monthNumbers) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: ListWheelScrollView.useDelegate(
        physics: const FixedExtentScrollPhysics(),
        itemExtent: _itemHeight,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: monthNumbers.length,
          builder: (context, index) => setListItem(
            index: index,
            text: monthNumbers[index].toString().padLeft(1, '0'),
            items: monthNumbers,
            selectedIndex: _selectedFrequency,
          ),
        ),
        onSelectedItemChanged: (index) {
          setState(() {
            _changeNumber(items: monthNumbers, value: monthNumbers.keys.elementAt(index));
            _selectedFrequency = monthNumbers.keys.elementAt(index);
          });
        },
      ),
    );
  }

  Widget _frequencyPickerColumn() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: ListWheelScrollView.useDelegate(
        physics: const FixedExtentScrollPhysics(),
        itemExtent: _itemHeight,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: items.length,
          builder: (context, index) => setListItem(
            index: index,
            text: getTextForPeriod(items[index] ?? Period.perMonth, value, context),
            items: items,
            selectedIndex: _selectedStringIndex,
          ),
        ),
        onSelectedItemChanged: (index) {
          setState(() {
            _changeStrPeriod(items: items, value: items.keys.elementAt(index));
            _selectedStringIndex = items.keys.elementAt(index);
          });
        },
      ),
    );
  }

  void _changeNumber({
    required Map items,
    required int value,
  }) {
    num = items[value].toString();
    widget.valueChanged(num, period);
  }

  void _changeStrPeriod({
    required Map<int, Period> items,
    required int value,
  }) {
    period = items[value] ?? Period.perMonth;
    widget.valueChanged(num, period);
  }
}

enum Period {
  perMonth,
  perYear,
}

String getTextForPeriod(Period period, int count, BuildContext context) {
  switch (period) {
    case Period.perMonth:
      return count == 1
          ? context.l10n.custom_exam_every_month_1
          : count <= 4
              ? context.l10n.custom_exam_every_month_less_4
              : context.l10n.custom_exam_every_month_more_4;
    case Period.perYear:
      return count == 1
          ? context.l10n.custom_exam_every_year_1
          : count <= 4
              ? context.l10n.custom_exam_every_year_less_4
              : context.l10n.custom_exam_every_year_more_4;
  }
}