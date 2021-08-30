import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    for (var i = 0; i < numberOfSteps; i++) {
      final text = (i + 1).toString();
      if (i < currentStep) {
        dots.add(const ProgressDot(style: ProgressDotStyle.done, text: ''));
      }
      if (i == currentStep) {
        dots.add(ProgressDot(style: ProgressDotStyle.doing, text: text));
      }
      if (i > currentStep) {
        dots.add(ProgressDot(style: ProgressDotStyle.todo, text: text));
      }
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        LayoutBuilder(
          builder: (_, constraints) {
            return Row(
              children: [
                ...List.generate(
                  constraints.maxWidth ~/ 13.5,
                  (_) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.5),
                    child: Container(
                      height: 1.5,
                      width: 10.5,
                      color: LoonoColors.beigeLight,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: dots,
        ),
      ],
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
        color: backgroundColor,
        border: Border.all(color: borderColor),
        shape: BoxShape.circle,
      ),
      child: Align(
        child: style == ProgressDotStyle.done
            ? SvgPicture.asset('assets/icons/check.svg', width: 16.0)
            : Text(
                text,
                style: TextStyle(
                  fontSize: size / 3,
                  color: textColor,
                ),
              ),
      ),
    );
  }

  Color get borderColor => textColor;

  Color get backgroundColor {
    switch (style) {
      case ProgressDotStyle.done:
        return LoonoColors.greenLight;
      case ProgressDotStyle.doing:
        return LoonoColors.beigeLighter;
      case ProgressDotStyle.todo:
        return Colors.white;
    }
  }

  Color get textColor {
    switch (style) {
      case ProgressDotStyle.done:
        return LoonoColors.green;
      case ProgressDotStyle.doing:
        return LoonoColors.primary;
      case ProgressDotStyle.todo:
        return LoonoColors.beigeLight;
    }
  }
}
