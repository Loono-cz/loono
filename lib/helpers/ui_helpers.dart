// ignore_for_file: avoid_classes_with_only_static_members
import 'package:flutter/material.dart';

class LoonoSizes {
  static bool isScreenSmall(BuildContext context) => MediaQuery.of(context).size.height <= 750;

  static double buttonBottomPadding(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return isScreenSmall(context) ? screenHeight * 0.075 : screenHeight * 0.15;
  }
}
