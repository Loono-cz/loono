import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/onboarding/carousel/indicator.dart';
import 'package:loono/ui/widgets/onboarding/carousel/story_page.dart';

const _sidePadding = 21.0;

class IndicatorRow extends StatelessWidget {
  const IndicatorRow({
    Key? key,
    this.currentIndex = 0,
    required this.numOfIndicators,
    required this.currentDuration,
    required this.currentStoryPageBackground,
    this.padding,
  })  : assert(currentIndex >= 0 && currentIndex < numOfIndicators),
        super(key: key);

  final int numOfIndicators;
  final int currentIndex;
  final Duration currentDuration;
  final StoryPageBackground currentStoryPageBackground;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(top: 70.0, left: _sidePadding, right: _sidePadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          numOfIndicators,
          (index) {
            return Indicator(
              maxWidth:
                  (MediaQuery.of(context).size.width - _sidePadding * 2) / numOfIndicators * 0.85,
              finished: index < currentIndex,
              shouldAnimate: index == currentIndex,
              duration: currentDuration,
              indicatorStyle: currentStoryPageBackground == StoryPageBackground.light
                  ? IndicatorStyle.dark()
                  : IndicatorStyle.light(),
            );
          },
        ),
      ),
    );
  }
}
