import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/video_player.dart';
import 'package:loono/ui/widgets/text_overlay.dart';

const textLines = [
  'Jsme Loono, tým mladých',
  'lékařů, studentů medicíny a',
  'mladých profesionálů'
];

class IntroVideo extends StatelessWidget {
  const IntroVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            const CustomVideoPlayer(type: FileType.assets, source: 'assets/intro_video.mp4'),
            TextOverlay(textLines: textLines),
          ],
        ),
      ),
    );
  }
}


// type: FileType.URL,
// source: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
