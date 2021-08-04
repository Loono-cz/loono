import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/video_player.dart';
import 'package:loono/ui/widgets/text_overlay.dart';

const textLines = [
  'Jsme Loono, tým mladých',
  'lékařů, studentů medicíny a',
  'mladých profesionálů'
];

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
            TextOverlay(textLines: textLines),
          ],
        ),
      ),
    );
  }
}


// type: FileType.URL,
// source: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
