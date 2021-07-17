import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/indicator.dart';

class IndicatorRow extends StatelessWidget {
  const IndicatorRow({
    Key? key,
    this.currentIndex = 0,
    this.numOfIndicators = 4,
  }) : super(key: key);

  final int numOfIndicators;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        numOfIndicators,
        (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Indicator(
              finished: index > currentIndex,
              shouldAnimate: index == currentIndex,
            ),
          );
        },
      ),
    );
  }
}
