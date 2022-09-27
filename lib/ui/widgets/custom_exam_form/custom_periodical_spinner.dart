import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/datepicker_helpers.dart';

const _itemHeight = 40.0;

enum FrequencyType { numbers, period }

class CustomPeriodicalSpinner extends StatefulWidget {
  const CustomPeriodicalSpinner({
    super.key,
    required this.valueChanged,
    this.stringPeriod,
    this.numberPeriod,
  });
  final Function(String, String) valueChanged;
  final String? stringPeriod;
  final String? numberPeriod;
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
          const Text('Jednou za'),
          _monthPickerColumn(),
          _frequencyPickerColumn(),
        ],
      ),
    );
  }

  Widget _monthPickerColumn() {
    final finalInterval = _selectedStringIndex >= 1 ? 10 : 11;
    final items =
        [for (var i = _selectedStringIndex == 1 ? 1 : 6; i <= finalInterval; i++) i].asMap();

    final selectedIndex = _selectedFrequency;

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
                  text: items[index].toString().padLeft(1, '0'),
                  items: items,
                  selectedIndex: selectedIndex,
                ),
              )
              .toList(),
        ),
        onSelectedItemChanged: (index) {
          _changeNumber(items: items, value: items.keys.elementAt(index));

          setState(() {
            _selectedFrequency = items.keys.elementAt(index);
          });
        },
      ),
    );
  }

  Widget _frequencyPickerColumn() {
    final items = List<String>.of(['měsíce', 'roky']).asMap();

    int selectedIndex;
    if (widget.stringPeriod!.isNotEmpty == true) {
      selectedIndex = items.values
          .toList()
          .indexOf(items.values.firstWhere((element) => element == widget.stringPeriod));
    } else {
      selectedIndex = _selectedStringIndex;
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: ListWheelScrollView.useDelegate(
        physics: const FixedExtentScrollPhysics(),
        itemExtent: _itemHeight,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: items.length,
          builder: (context, index) => setListItem(
            index: index,
            text: items[index].toString().padLeft(1, '0'),
            items: items,
            selectedIndex: selectedIndex,
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
