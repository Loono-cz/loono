import 'package:flutter/material.dart';

extension ScreenSize on MediaQueryData {
  bool get isTextBig => textScaleFactor >= 1.5;

  bool get isMobileScreen => size.height <= 750;

  bool get useCompactStyle => isTextBig;

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