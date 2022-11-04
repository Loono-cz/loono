import 'package:flutter/material.dart';
import 'package:loono/helpers/size_helpers.dart';

///Space between widgets
class Space extends StatelessWidget {
  const Space({Key? key, required this.verticalSpace, required this.horizontalSpace})
      : super(key: key);

  ///Vertical space between widgets
  const Space.vertical(double space, {Key? key})
      : horizontalSpace = space,
        verticalSpace = 0,
        super(key: key);

  ///Horizontal space between widgets
  const Space.horizontal( double space,{Key? key})
      : horizontalSpace = 0,
        verticalSpace = space,
        super(key: key);

  final double verticalSpace;
  final double horizontalSpace;

  @override
  Widget build(BuildContext context) {
    final height = context.mediaQuery.compactSizeOf(horizontalSpace);
    final width = context.mediaQuery.compactSizeOf(verticalSpace);
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
