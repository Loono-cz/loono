import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/helpers/self_examination_category.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/prevention/self_examination/how_it_went_sheet.dart';
import 'package:loono_api/loono_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EducationalVideoScreen extends StatelessWidget {
  const EducationalVideoScreen({
    Key? key,
    required this.sex,
    required this.selfExamination,
  }) : super(key: key);
  final Sex sex;
  final SelfExaminationPreventionStatus selfExamination;

  String _getVideoIdFromSex() {
    if (sex == Sex.FEMALE) {
      return 'xfkSnGt9U80';
    } else {
      return 'HHJpDtxuXZQ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        key: const Key('educationalVideoPage_video'),
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
                  key: const Key('educationalVideoPage_closeBtn'),
                  icon: const Icon(
                    Icons.close,
                    size: 32,
                  ),
                  onPressed: () => AutoRouter.of(context).pop(),
                ),
                const SizedBox(height: 24),
                player,
                const SizedBox(height: 48),
                if (selfExamination.calculateStatus() == const SelfExaminationCategory.active() ||
                    selfExamination.calculateStatus() == const SelfExaminationCategory.first())
                  LoonoButton(
                    key: const Key('educationalVideoPage_btn_selfExamPerformed'),
                    text: context.l10n.self_examination_educational_button,
                    onTap: () async {
                      await AutoRouter.of(context).pop();
                      showHowItWentSheet(context, sex, selfExamination);
                    },
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
