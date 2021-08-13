import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/onboarding/carousel/indicator.dart';
import 'package:loono/ui/widgets/onboarding/carousel/story_page.dart';

const _sidePadding = 17.0;
const _sizeRatio = 0.936;

class IndicatorRow extends StatelessWidget {
  const IndicatorRow({
    Key? key,
    this.currentIndex = 0,
    required this.numOfIndicators,
    required this.currentDuration,
    required this.currentStoryPageBackground,
    this.padding = const EdgeInsets.only(top: 60.0, left: _sidePadding, right: _sidePadding),
    this.onStoryFinish,
  })  : assert(numOfIndicators > 0),
        assert(currentIndex >= 0 && currentIndex < numOfIndicators),
        super(key: key);

  final int numOfIndicators;
  final int currentIndex;
  final Duration currentDuration;
  final StoryPageBackground currentStoryPageBackground;
  final EdgeInsets padding;
  final VoidCallback? onStoryFinish;

  @override
  Widget build(BuildContext context) {
    final itemMaxWidth =
        (MediaQuery.of(context).size.width - _sidePadding * 2) / numOfIndicators * _sizeRatio;

    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment:
            numOfIndicators == 1 ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
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
              onFinish: onStoryFinish,
            );
          },
        ),
      ),
    );
  }
}
