import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';

class Reward {
  String title;
  String imagePath;
  int points;

  Reward(this.title, this.imagePath, this.points);
}

void showConfirmationSheet(BuildContext context, ExaminationType examinationType) {
  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    builder: (BuildContext context) {
      final practitioner =
          procedureQuestionTitle(context, examinationType: examinationType).toLowerCase();
      final preposition = czechPreposition(context, examinationType: examinationType);

      void _completedAction() {
        AutoRouter.of(context).popUntilRouteWithName('ExaminationDetailRoute');
        showSnackBarError(context, message: 'TODO: save to API');
      }

      return Container(
        height: 340,
        decoration: const BoxDecoration(
          color: LoonoColors.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => AutoRouter.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${context.l10n.checkup_confirmation_title} $preposition $practitioner?',
                  style: LoonoFonts.headerFontStyle,
                ),
                const SizedBox(
                  height: 60,
                ),
                LoonoButton.light(
                  text: 'Ano, byl/a jsem na prohlídce',
                  onTap: () => {
                    AutoRouter.of(context).navigate(
                      AchievementRoute(
                        header: 'TO DO: complete all rewards',
                        textLines: [context.l10n.award_desc],
                        numberOfPoints: examinationType.awardPoints,
                        itemPath: 'assets/icons/coat-practitioner.svg',
                        onButtonTap: _completedAction,
                      ),
                    ),
                  },
                  enabledColor: LoonoColors.primaryEnabled,
                  textColor: Colors.white,
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
