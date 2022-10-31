import 'dart:developer';

import 'package:flutter/material.dart';

extension ScreenSize on MediaQueryData {
  bool get isTextBig => textScaleFactor >= 1.5;

  bool get isMobileScreen => size.height <= 750;
  bool get isScreenSmall => size.height <= 300;

  bool get useCompactStyle => isTextBig || isScreenSmall;

  double compactSizeOf(double size) {
    if(useCompactStyle) {
      log('size ($size): ${size / textScaleFactor}');
      return size / textScaleFactor;
    }
    else {
      return size;
    }
  }
}

extension MediaQueryContextExt on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}