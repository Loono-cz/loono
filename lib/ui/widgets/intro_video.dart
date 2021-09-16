import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/onboarding/carousel/button.dart';
import 'package:loono/ui/widgets/onboarding/carousel/story_page.dart';
import 'package:loono/ui/widgets/text_overlay.dart';
import 'package:loono/ui/widgets/video_player.dart';

class IntroVideo extends StatelessWidget {
  const IntroVideo({
    Key? key,
    this.onVideoLoaded,
    required this.storyPageState,
  }) : super(key: key);

  final VoidCallback? onVideoLoaded;
  final StoryPageState storyPageState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            CustomVideoPlayer(
              type: FileType.assets,
              source: 'assets/intro_video.mp4',
              onLoaded: onVideoLoaded,
              storyPageState: storyPageState,
            ),
            TextOverlay(textLines: context.l10n.carousel_content_1_body.split('\n')),
          ],
        ),
      ),
    );
  }
}

class OnboardFirstCarouselInteractiveContent extends StatelessWidget {
  const OnboardFirstCarouselInteractiveContent({
    Key? key,
    required this.storyPageState,
    this.onVolumeTap,
    this.onButtonTap,
  }) : super(key: key);

  final StoryPageState storyPageState;
  final VoidCallback? onVolumeTap;
  final VoidCallback? onButtonTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height * 0.1,
          left: 20.0,
          child: Material(
            color: Colors.transparent,
            // TODO: Change/update this volume icon once it is added to Figma
            child: IconButton(
              icon: Icon(
                storyPageState.isMuted ? Icons.volume_off : Icons.volume_up,
                size: 40.0,
                color: Colors.white,
              ),
              onPressed: onVolumeTap,
            ),
          ),
        ),
        CarouselButton(text: context.l10n.continue_info, onTap: onButtonTap),
      ],
    );
  }
}
