import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/video_player.dart';

const textLines = [
  'Jsme Loono, tým mladých',
  'lékařů, studentů medicíny a',
  'mladých profesionálů'
];

class IntroVideoScreen extends StatelessWidget {
  final double fontSize = 48;
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
              Container(
                alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.2),
                child: Wrap(
                    direction: Axis.vertical,
                    spacing: 16.0,
                    children: textLines.map((textLine) => Container(
                        color: Colors.white,
                        child: Text(
                          textLine,
                          style: TextStyle(fontSize: fontSize),
                        )
                      )
                    ).toList()
                )
              )
            ]
          )
        )
    );
  }
}


// type: FileType.URL,
// source: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
