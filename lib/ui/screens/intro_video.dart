import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/video_player.dart';
import 'package:loono/ui/widgets/text_overlay.dart';

const textLines = [
  'Jsme Loono, tým mladých',
  'lékařů, studentů medicíny a',
  'mladých profesionálů'
];

class IntroVideoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Stack(
            fit: StackFit.loose,
            children: [
              CustomVideoPlayer(
                  type: FileType.ASSETS,
                  source: 'assets/intro_video.mp4'
              ),
              TextOverlay(textLines: textLines)
            ]
          )
        )
    );
  }
}


// type: FileType.URL,
// source: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
