import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/onboarding/carousel/story_page.dart';
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

            /// subtitle disable for now on request of PO
            //TextOverlay(textLines: context.l10n.carousel_content_1_body.split('\n')),
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
          right: 10.0,
          child: ButtonTheme(
            height: 30,
            minWidth: 30,
            child: MaterialButton(
              color: LoonoColors.beigeLighter,
              onPressed: onVolumeTap,
              shape: const CircleBorder(),
              child: (storyPageState.isMuted)
                  ? SvgPicture.asset('assets/icons/sound_off.svg')
                  : SvgPicture.asset('assets/icons/sound_on.svg'),
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
