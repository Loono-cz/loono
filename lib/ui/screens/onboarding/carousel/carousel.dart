import 'package:flutter/material.dart';
import 'package:loono/ui/screens/onboarding/carousel/carousel_fourth.dart';
import 'package:loono/ui/screens/onboarding/carousel/carousel_second.dart';
import 'package:loono/ui/screens/onboarding/carousel/carousel_third.dart';
import 'package:loono/ui/widgets/intro_video.dart';
import 'package:loono/ui/widgets/onboarding/carousel/indicator_row.dart';
import 'package:loono/ui/widgets/onboarding/carousel/story_page.dart';
import 'package:loono/ui/widgets/onboarding/carousel/tap_area.dart';

class OnboardingCarouselScreen extends StatefulWidget {
  const OnboardingCarouselScreen({Key? key}) : super(key: key);

  @override
  _OnboardingCarouselScreenState createState() => _OnboardingCarouselScreenState();
}

class _OnboardingCarouselScreenState extends State<OnboardingCarouselScreen> {
  final PageController pageController = PageController();

  int get currentPageIndex => pageController.hasClients ? pageController.page?.round() ?? 0 : 0;

  bool get canTransitionToPrevStory => currentPageIndex > 0;

  bool get canTransitionToNextStory => currentPageIndex < stories.length - 1;

  void jumpToPrevStory() => pageController.jumpToPage(currentPageIndex - 1);

  void jumpToNextStory() => pageController.jumpToPage(currentPageIndex + 1);

  final stories = const <StoryPage>[
    StoryPage.dark(content: IntroVideo(), duration: Duration(seconds: 13)),
    StoryPage(content: OnboardingSecondCarouselScreen()),
    StoryPage(content: OnboardingThirdCarouselScreen()),
    StoryPage(
      content: OnboardFourthCarouselScreen(),
      interactiveContent: OnboardFourthCarouselInteractiveContent(),
    ),
  ];

  StoryPage get currentStory => stories[currentPageIndex];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (_) => setState(() {}),
            controller: pageController,
            children: stories,
          ),
          IndicatorRow(
            numOfIndicators: stories.length,
            currentIndex: currentPageIndex,
            currentDuration: currentStory.duration,
            currentStoryPageBackground: currentStory.storyPageBackground,
            onStoryFinish: canTransitionToNextStory ? jumpToNextStory : null,
          ),
          if (canTransitionToPrevStory) TapArea.leftSide(onTap: jumpToPrevStory),
          if (canTransitionToNextStory) TapArea.rightSide(onTap: jumpToNextStory),
          if (currentStory.hasInteractiveContent) currentStory.interactiveContent!,
        ],
      ),
    );
  }
}
