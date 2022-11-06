import 'package:flutter/material.dart';

extension ScreenSize on MediaQueryData {
  bool get isTextBig => textScaleFactor >= 1.5;

  bool get isMobileScreen => size.height <= 750;
  bool get isScreenSmall => size.height <= 300;

  ///Is screen small or is font size big
  bool get useCompactStyle => isTextBig || isScreenSmall;

  ///when [useCompactStyle] return lesser size
  double compactSizeOf(double size) {
    if(useCompactStyle) {
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