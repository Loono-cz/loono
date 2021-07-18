import 'dart:math';
import 'package:flutter/material.dart';

class TextOverlay extends StatelessWidget {
  final double fontSizeRatio = 1.9;
  final double spacingRatio = 0.013;
  final int? maxLineLength;
  final List<String> textLines;

  TextOverlay({required this.textLines, Key? key})
      : maxLineLength = textLines.map((line) => line.length).reduce(max),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.2),
      child: Wrap(
        direction: Axis.vertical,
        spacing: spacingRatio * MediaQuery.of(context).size.height,
        children: textLines
            .map(
              (textLine) => Container(
                color: Colors.white,
                child: Text(
                  textLine,
                  style: TextStyle(
                    fontSize: fontSizeRatio * (MediaQuery.of(context).size.width / maxLineLength!),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
