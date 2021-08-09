import 'dart:math';

import 'package:flutter/material.dart';

const _fontSizeRatio = 1.9;
const _spacingRatio = 0.013;

class TextOverlay extends StatelessWidget {
  TextOverlay({Key? key, this.padding, required this.textLines})
      : maxLineLength = textLines.map((line) => line.length).reduce(max),
        super(key: key);

  late final int maxLineLength;

  final EdgeInsets? padding;
  final List<String> textLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: padding,
      child: Wrap(
        direction: Axis.vertical,
        spacing: _spacingRatio * MediaQuery.of(context).size.height,
        children: textLines
            .map(
              (textLine) => Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    textLine,
                    style: TextStyle(
                      fontSize:
                          _fontSizeRatio * (MediaQuery.of(context).size.width / maxLineLength),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
