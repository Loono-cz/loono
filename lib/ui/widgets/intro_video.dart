import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/button.dart';
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
    this.onResetTap,
    this.onContinueTap,
  }) : super(key: key);

  final StoryPageState storyPageState;
  final VoidCallback? onVolumeTap;
  final VoidCallback? onResetTap;
  final VoidCallback? onContinueTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height * 0.1,
          left: 20.0,
          child: Material(
            color: Colors.transparent,
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
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.14,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                padding: const EdgeInsets.only(left: 20.0, right: 7.5),
                child: LoonoButton.light(
                  text: context.l10n.carousel_content_1_reset_button,
                  onTap: onResetTap,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                padding: const EdgeInsets.only(left: 7.5, right: 20.0),
                child: LoonoButton(text: context.l10n.continue_info, onTap: onContinueTap),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
