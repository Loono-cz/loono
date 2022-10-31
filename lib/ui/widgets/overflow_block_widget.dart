import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loono/helpers/size_helpers.dart';

class OverflowBlockWidget extends StatelessWidget {

  const OverflowBlockWidget({Key? key, required this.child}): super(key: key);

  final Widget child;

   Element get element => child.createElement();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        log('widget height: ${constraints.maxHeight}\nscreen height: ${context
            .mediaQuery.size.height}',);
        if (context.mediaQuery.size.height >= constraints.maxHeight) {
          return child;
        } else {
          return SingleChildScrollView(
            child: child,
          );
        }
      },
    );
  }
}