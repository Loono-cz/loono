import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/onboarding/carousel/button.dart';
import 'package:loono/ui/widgets/text_overlay.dart';
import 'package:loono/ui/widgets/video_player.dart';

class IntroVideo extends StatelessWidget {
  const IntroVideo({
    Key? key,
    this.onVideoLoaded,
    this.videoPaused = false,
    this.pageState = 0,
  }) : super(key: key);

  final VoidCallback? onVideoLoaded;
  final bool videoPaused;
  final int pageState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            CustomVideoPlayer(
              type: FileType.assets,
              source: 'assets/intro_video.mp4',
              paused: videoPaused,
              onLoaded: onVideoLoaded,
              currentPage: pageState,
            ),
            TextOverlay(textLines: context.l10n.carousel_content_1_body.split('\n')),
          ],
        ),
      ),
    );
  }
}

class OnboardFirstCarouselInteractiveContent extends StatelessWidget {
  const OnboardFirstCarouselInteractiveContent({Key? key, this.onTap}) : super(key: key);

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CarouselButton(text: context.l10n.continue_info, onTap: onTap);
  }
}
