import 'package:flutter/material.dart';
import 'package:loono/constants.dart';

Widget setListItem({
  required int index,
  required String text,
  required Map<int, Object> items,
  required int selectedIndex,
}) {
  final keys = items.keys.toList()..sort();

  final firstOrLastCoupleInList =
      (((selectedIndex == keys.last) && (index == keys.first || index == keys.first + 1)) ||
              (selectedIndex == keys.last - 1) && (index == keys.first)) ||
          (((selectedIndex == keys.first) && (index == keys.last || index == keys.last - 1)) ||
              (selectedIndex == keys.first + 1) && (index == keys.last));

  var opacityValue = 0.2;

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
      ),
    ),
  );
}
