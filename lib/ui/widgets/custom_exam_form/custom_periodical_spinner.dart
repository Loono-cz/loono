import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/datepicker_helpers.dart';
import 'package:loono/l10n/ext.dart';

const _itemHeight = 30.0;

enum FrequencyType { numbers, period }

final items = List<String>.of(['měsíce', 'roky']).asMap();

class CustomPeriodicalSpinner extends StatefulWidget {
  const CustomPeriodicalSpinner({
    super.key,
    required this.valueChanged,
  });
  final Function(String, String) valueChanged;
  @override
  State<CustomPeriodicalSpinner> createState() => _CustomPeriodicalSpinnerState();
}

class _CustomPeriodicalSpinnerState extends State<CustomPeriodicalSpinner> {
  int _selectedFrequency = 0;
  int _selectedStringIndex = 0;

  var num = '';
  var period = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final finalInterval = _selectedStringIndex >= 1 ? 10 : 11;
    final monthNumbers =
        [for (var i = _selectedStringIndex == 1 ? 1 : 6; i <= finalInterval; i++) i].asMap();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 4.0),
          child: Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: LoonoColors.primaryEnabled,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Text(
          context.l10n.once_per,
          style: LoonoFonts.spinnerTextOnceTo,
        ),
        _monthPickerColumn(monthNumbers),
        _frequencyPickerColumn(),
      ],
    );
  }

  Widget _monthPickerColumn(Map<int, int> monthNumbers) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
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
          _changeNumber(items: monthNumbers, value: monthNumbers.keys.elementAt(index));

          setState(() {
            _selectedFrequency = monthNumbers.keys.elementAt(index);
          });
        },
      ),
    );
  }

  Widget _frequencyPickerColumn() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      child: ListWheelScrollView.useDelegate(
        physics: const FixedExtentScrollPhysics(),
        itemExtent: _itemHeight,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: items.length,
          builder: (context, index) => setListItem(
            index: index,
            text: items[index].toString().padLeft(1, '0'),
            items: items,
            selectedIndex: _selectedStringIndex,
          ),
        ),
        onSelectedItemChanged: (index) {
          _changeStrPeriod(items: items, value: items.keys.elementAt(index));
          setState(() {
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
    required Map items,
    required int value,
  }) {
    period = items[value].toString();
    widget.valueChanged(num, period);
  }
}
