import 'package:flutter/cupertino.dart';

BoxConstraints get searchIconConstraints {
  const extraIconPadding = 6.0;
  const defaultIconSize = 18.0 + extraIconPadding;
  return BoxConstraints.loose(const Size.square(defaultIconSize));
}
