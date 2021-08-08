import 'package:flutter/material.dart';
import '../../constants.dart';

class LoonoProgressIndicator extends StatelessWidget {
  final int numberOfSteps;
  final int currentStep;
  final double size;

  const LoonoProgressIndicator({
    required this.numberOfSteps,
    required this.currentStep,
    this.size = 34,
  });

  @override
  Widget build(BuildContext context) {
    final dots = <Widget>[];
    for (var i = 1; i <= numberOfSteps; i++) {
      final text = (i).toString();
      if (i < currentStep) {
        dots.add(const ProgressDot(style: ProgressDotStyle.done, text: "✔︎"));
      }
      if (i == currentStep) {
        dots.add(ProgressDot(style: ProgressDotStyle.doing, text: text));
      }
      if (i > currentStep) {
        dots.add(ProgressDot(style: ProgressDotStyle.todo, text: text));
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: dots,
    );
  }
}

enum ProgressDotStyle { done, doing, todo }

class ProgressDot extends StatelessWidget {
  final double size;
  final ProgressDotStyle style;
  final String text;

  const ProgressDot({
    this.size = 34,
    required this.style,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor(),
        border: style == ProgressDotStyle.todo
            ? Border.all(color: LoonoColors.lightGray)
            : Border.all(color: LoonoColors.primary),
        shape: BoxShape.circle,
      ),
      child: Align(
        child: Text(text,
            style: TextStyle(
              fontSize: size / 3,
              color: textColor(),
            )),
      ),
    );
  }

  Color backgroundColor() {
    switch (style) {
      case ProgressDotStyle.done:
        return LoonoColors.green;
      case ProgressDotStyle.doing:
        return LoonoColors.inactiveButtonFace;
      case ProgressDotStyle.todo:
        return LoonoColors.lightGray;
    }
  }

  Color textColor() {
    switch (style) {
      case ProgressDotStyle.done:
        return Colors.white;
      case ProgressDotStyle.doing:
        return LoonoColors.primary;
      case ProgressDotStyle.todo:
        return LoonoColors.gray;
    }
  }
}
