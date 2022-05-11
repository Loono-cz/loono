// ignore_for_file: unnecessary_lambdas

import 'package:flutter/material.dart';
import 'package:loono/ui/screens/onboarding/carousel/carousel_second.dart';
import 'package:loono/ui/widgets/intro_video.dart';
import 'package:loono/ui/widgets/onboarding/carousel/indicator_row.dart';
import 'package:loono/ui/widgets/onboarding/carousel/story_page.dart';
import 'package:loono/ui/widgets/onboarding/carousel/tap_area.dart';

const _pageAnimDuration = Duration(milliseconds: 400);

class IntroCarouselScreen extends StatefulWidget {
  const IntroCarouselScreen({Key? key}) : super(key: key);

  @override
  _IntroCarouselScreenState createState() => _IntroCarouselScreenState();
}

class _IntroCarouselScreenState extends State<IntroCarouselScreen> {
  final PageController pageController = PageController();

  final StoryPageState storyStateController = StoryPageState();

  StoryPageState get storyPageState =>
      storyStateController.copyWith(pageIndexState: currentPageIndex);

  List<StoryPage> get _allStories => <StoryPage>[
        StoryPage.dark(
          content: IntroVideo(onVideoLoaded: loadStory, storyPageState: storyPageState),
          interactiveContent: OnboardFirstCarouselInteractiveContent(
            storyPageState: storyPageState,
            onVolumeTap: storyPageState.isMuted ? unmuteStory : muteStory,
            onResetTap: resetStory,
            onContinueTap: animToNextStory,
          ),
          indicatorVisible: true,
          duration: const Duration(milliseconds: 8000),
          autoplay: false,
        ),
        StoryPage(content: OnboardingSecondCarouselScreen(onBack: animToPrevStory)),
      ];

  List<StoryPage> get stories => _allStories.where((story) => story.indicatorVisible).toList();

  @override
  void initState() {
    super.initState();
    if (stories.isNotEmpty && stories.first.autoplay) playStory();
  }

  void loadStory() {
    if (!storyPageState.isPlaying) playStory();
  }

  void resetStory() => setState(() => storyStateController.reset());

  void playStory([DragEndDetails? details]) => setState(() => storyStateController.unpause());

  void pauseStory([DragDownDetails? details]) => setState(() => storyStateController.pause());

  void muteStory() => setState(() => storyStateController.mute());

  void unmuteStory() => setState(() => storyStateController.unmute());

  int get currentPageIndex => pageController.hasClients ? pageController.page?.round() ?? 0 : 0;

  bool get canTransitionToPrevStory => currentPageIndex > 0 && currentPageIndex < stories.length;

  bool get canTransitionToNextStory => currentPageIndex < stories.length - 1;

  void jumpToPrevStory() => pageController.jumpToPage(currentPageIndex - 1);

  void jumpToNextStory() => pageController.jumpToPage(currentPageIndex + 1);

  void animToPrevStory() => pageController.animateToPage(
        currentPageIndex - 1,
        duration: _pageAnimDuration,
        curve: Curves.linearToEaseOut.flipped,
      );

  void animToNextStory() => pageController.animateToPage(
        currentPageIndex + 1,
        duration: _pageAnimDuration,
        curve: Curves.linearToEaseOut,
      );

  StoryPage get currentStory => _allStories[currentPageIndex];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => currentPageIndex != 0,
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            PageView(
              onPageChanged: (_) => currentStory.autoplay ? playStory() : pauseStory(),
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _allStories,
            ),
            if (currentStory.indicatorVisible) ...[
              IndicatorRow(
                numOfIndicators: stories.length,
                currentIndex: currentPageIndex,
                currentDuration: currentStory.duration,
                currentStoryPageBackground: currentStory.storyPageBackground,
                onStoryFinish: canTransitionToNextStory ? jumpToNextStory : null,
                storyPageState: storyPageState,
              ),
              if (canTransitionToPrevStory) TapArea.leftSide(onTap: jumpToPrevStory),
              if (canTransitionToNextStory) TapArea.rightSide(onTap: jumpToNextStory),
              if (stories.isNotEmpty) TapArea.max(onPanDown: pauseStory, onPanEnd: playStory),
              if (currentStory.hasInteractiveContent) currentStory.interactiveContent!,
            ],
          ],
        ),
      ),
    );
  }
}
