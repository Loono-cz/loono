import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono_api/loono_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EducationalVideoScreen extends StatelessWidget {
  const EducationalVideoScreen({Key? key, required this.sex}) : super(key: key);
  final Sex sex;

  String _getVideoIdFromSex() {
    if (sex == Sex.FEMALE) {
      return 'HHJpDtxuXZQ';
    } else {
      return 'HHJpDtxuXZQ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: _getVideoIdFromSex(),
          flags: const YoutubePlayerFlags(
            autoPlay: false,
          ),
        ),
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 32,
                  ),
                  onPressed: () => AutoRouter.of(context).pop(),
                ),
                const SizedBox(height: 24),
                player,
                const SizedBox(height: 48),
                LoonoButton(
                  text: 'Vyšetřila jsem se',
                  onTap: () => AutoRouter.of(context).pop(),
                ),
                SizedBox(height: LoonoSizes.buttonBottomPadding(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
