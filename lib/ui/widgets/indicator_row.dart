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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        numOfIndicators,
        (index) {
          return Indicator(
            finished: index < currentIndex,
            shouldAnimate: index == currentIndex,
            maxWidth: MediaQuery.of(context).size.width / numOfIndicators * 0.75,
          );
        },
      ),
    );
  }
}
