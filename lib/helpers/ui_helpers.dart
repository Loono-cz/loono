// ignore_for_file: avoid_classes_with_only_static_members
import 'package:flutter/material.dart';

class LoonoSizes {
  static double buttonBottomPadding(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight > 750 ? screenHeight * 0.15 : screenHeight * 0.075;
  }
}
