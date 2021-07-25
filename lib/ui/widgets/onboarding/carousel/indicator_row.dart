import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/onboarding/carousel/indicator.dart';
import 'package:loono/ui/widgets/onboarding/carousel/story_page.dart';

const _sidePadding = 19.0;
const _sizeRatio = 0.936;

class IndicatorRow extends StatelessWidget {
  const IndicatorRow({
    Key? key,
    this.currentIndex = 0,
    required this.numOfIndicators,
    required this.currentDuration,
    required this.currentStoryPageBackground,
    this.padding = const EdgeInsets.only(top: 60.0, left: _sidePadding, right: _sidePadding),
  })  : assert(currentIndex >= 0 && currentIndex < numOfIndicators),
        assert(numOfIndicators >= 0),
        super(key: key);

  final int numOfIndicators;
  final int currentIndex;
  final Duration currentDuration;
  final StoryPageBackground currentStoryPageBackground;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final itemMaxWidth =
        (MediaQuery.of(context).size.width - _sidePadding * 2) / numOfIndicators * _sizeRatio;

    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          numOfIndicators,
          (index) {
            return Indicator(
              maxWidth: itemMaxWidth,
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
