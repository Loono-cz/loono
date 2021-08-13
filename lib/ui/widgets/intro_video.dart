import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/onboarding/carousel/button.dart';
import 'package:loono/ui/widgets/text_overlay.dart';
import 'package:loono/ui/widgets/video_player.dart';

class IntroVideo extends StatelessWidget {
  const IntroVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            const CustomVideoPlayer(type: FileType.assets, source: 'assets/intro_video.mp4'),
            TextOverlay(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.53),
              textLines: context.l10n.carousel_content_1_body.split('\n'),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardFirstCarouselInteractiveContent extends StatelessWidget {
  const OnboardFirstCarouselInteractiveContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselButton(
      text: context.l10n.continue_info,
      onTap: () => Navigator.pushNamed(context, '/onboarding/carousel2'),
    );
  }
}
