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

  bool playStoryState = false;

  bool get isStoryPaused => playStoryState == false;

  List<StoryPage> get stories => <StoryPage>[
    // const StoryPage(content: OnboardingSecondCarouselScreen(), duration: Duration(milliseconds: 3000)),
    StoryPage.dark(
          content: IntroVideo(
            onVideoLoaded: loadStory,
            videoPaused: isStoryPaused,
            pageViewPage: currentPageIndex,
          ),
          duration: const Duration(milliseconds: 12700),
      autoplay: false,
    ),
    // 3000ms je jen temporary na testovani, jestli se updatuje delka animace u ostatnich na default
    const StoryPage(content: OnboardingSecondCarouselScreen(), duration: Duration(milliseconds: 3000)),
    const StoryPage(content: OnboardingThirdCarouselScreen()),
    const StoryPage(
      content: OnboardFourthCarouselScreen(),
      interactiveContent: OnboardFourthCarouselInteractiveContent(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    if (stories.isNotEmpty && stories.first.autoplay) startStory();
  }

  void loadStory() {
    if (!playStoryState) setState(() => playStoryState = true);
  }

  void startStory() => setState(() => playStoryState = true);

  void pauseStory() => setState(() => playStoryState = false);

  int get currentPageIndex => pageController.hasClients ? pageController.page?.round() ?? 0 : 0;

  bool get canTransitionToPrevStory => currentPageIndex > 0;

  bool get canTransitionToNextStory => currentPageIndex < stories.length - 1;

  void jumpToPrevStory() => pageController.jumpToPage(currentPageIndex - 1);

  void jumpToNextStory() => pageController.jumpToPage(currentPageIndex + 1);

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
            onPageChanged: (_) => currentStory.autoplay ? startStory() : pauseStory(),
            controller: pageController,
            children: stories,
          ),
          IndicatorRow(
            numOfIndicators: stories.length,
            currentIndex: currentPageIndex,
            currentDuration: currentStory.duration,
            currentStoryPageBackground: currentStory.storyPageBackground,
            onStoryFinish: canTransitionToNextStory ? jumpToNextStory : null,
            paused: isStoryPaused,
          ),
          if (canTransitionToPrevStory) TapArea.leftSide(onTap: jumpToPrevStory),
          if (canTransitionToNextStory) TapArea.rightSide(onTap: jumpToNextStory),
          if (stories.isNotEmpty) TapArea.max(onLongPress: pauseStory, onLongPressUp: startStory),
          if (currentStory.hasInteractiveContent) currentStory.interactiveContent!,
        ],
      ),
    );
  }
}
