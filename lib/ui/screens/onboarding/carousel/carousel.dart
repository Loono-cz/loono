import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
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

  List<StoryPage> get stories => <StoryPage>[
        const StoryPage.dark(content: IntroVideo(), duration: Duration(seconds: 13)),
        const StoryPage(content: OnboardingSecondCarouselScreen()),
        const StoryPage(content: OnboardingThirdCarouselScreen()),
        StoryPage(
          content: const OnboardFourthCarouselScreen(),
          interactiveContent: Positioned(
            bottom: 120.0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: TextButton(
                style: ButtonStyle(
                  alignment: Alignment.center,
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(LoonoColors.primary),
                ),
                onPressed: () => Navigator.pushNamed(context, '/onboarding/gender'),
                child: const Text('Beru zdraví do svých rukou'),
              ),
            ),
          ),
        ),
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
          if (currentStory.hasInteractiveContent) currentStory.interactiveContent!,
        ],
      ),
    );
  }
}
