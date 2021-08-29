import 'package:flutter/material.dart';
import 'package:loono/ui/screens/onboarding/carousel/carousel_second.dart';
import 'package:loono/ui/screens/onboarding/carousel/carousel_third.dart';
import 'package:loono/ui/widgets/intro_video.dart';
import 'package:loono/ui/widgets/onboarding/carousel/indicator_row.dart';
import 'package:loono/ui/widgets/onboarding/carousel/story_page.dart';
import 'package:loono/ui/widgets/onboarding/carousel/tap_area.dart';

const _pageAnimDuration = Duration(milliseconds: 400);

class OnboardingCarouselScreen extends StatefulWidget {
  const OnboardingCarouselScreen({Key? key}) : super(key: key);

  @override
  _OnboardingCarouselScreenState createState() => _OnboardingCarouselScreenState();
}

class _OnboardingCarouselScreenState extends State<OnboardingCarouselScreen> {
  final PageController pageController = PageController();

  bool playStoryState = false;

  bool get isStoryPaused => playStoryState == false;

  List<StoryPage> get _allStories => <StoryPage>[
        StoryPage.dark(
          content: IntroVideo(
            onVideoLoaded: loadStory,
            videoPaused: isStoryPaused,
            pageState: currentPageIndex,
          ),
          interactiveContent: OnboardFirstCarouselInteractiveContent(onTap: animToNextStory),
          indicatorVisible: true,
          duration: const Duration(milliseconds: 12700),
          autoplay: false,
        ),
        StoryPage(
          content: OnboardingSecondCarouselScreen(onBack: animToPrevStory, onNext: animToNextStory),
        ),
        StoryPage(content: OnboardingThirdCarouselScreen(onBack: animToPrevStory)),
      ];

  List<StoryPage> get stories => _allStories.where((story) => story.indicatorVisible).toList();

  @override
  void initState() {
    super.initState();
    if (stories.isNotEmpty && stories.first.autoplay) playStory();
  }

  void loadStory() {
    if (!playStoryState) setState(() => playStoryState = true);
  }

  void playStory() => setState(() => playStoryState = true);

  void pauseStory() => setState(() => playStoryState = false);

  int get currentPageIndex => pageController.hasClients ? pageController.page?.round() ?? 0 : 0;

  bool get canTransitionToPrevStory => currentPageIndex > 0 && currentPageIndex < stories.length;

  bool get canTransitionToNextStory => currentPageIndex < stories.length - 1;

  void jumpToPrevStory() => pageController.jumpToPage(currentPageIndex - 1);

  void jumpToNextStory() => pageController.jumpToPage(currentPageIndex + 1);

  void animToPrevStory() => pageController.animateToPage(currentPageIndex - 1,
      duration: _pageAnimDuration, curve: Curves.linearToEaseOut.flipped);

  void animToNextStory() => pageController.animateToPage(currentPageIndex + 1,
      duration: _pageAnimDuration, curve: Curves.linearToEaseOut);

  StoryPage get currentStory => _allStories[currentPageIndex];

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
            onPageChanged: (_) => currentStory.autoplay ? playStory() : pauseStory(),
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: _allStories,
          ),
          if (currentStory.indicatorVisible)
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
          if (currentStory.indicatorVisible) ...[
            if (stories.isNotEmpty) TapArea.max(onLongPress: pauseStory, onLongPressUp: playStory),
            if (currentStory.hasInteractiveContent) currentStory.interactiveContent!,
          ],
        ],
      ),
    );
  }
}
