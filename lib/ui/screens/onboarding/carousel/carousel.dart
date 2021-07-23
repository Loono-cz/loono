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

  void jumpToPrevPage() => pageController.jumpToPage(currentPageIndex - 1);

  void jumpToNextPage() => pageController.jumpToPage(currentPageIndex + 1);

  final stories = const <StoryPage>[
    StoryPage.dark(
      content: Scaffold(body: Center(child: IntroVideo())),
      duration: Duration(seconds: 12),
    ),
    StoryPage(content: OnboardingSecondCarouselScreen()),
    StoryPage(content: OnboardingThirdCarouselScreen()),
    StoryPage(content: OnboardFourthCarouselScreen()),
  ];

  StoryPage get currentStory => stories[currentPageIndex];

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
          ),
          if (currentPageIndex > 0) TapArea.leftSide(onTap: jumpToPrevPage),
          if (currentPageIndex < stories.length - 1) TapArea.rightSide(onTap: jumpToNextPage),
        ],
      ),
    );
  }
}
