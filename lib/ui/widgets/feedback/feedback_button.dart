import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/feedback/rating_bottom_sheet.dart';

class FeedbackButton extends StatelessWidget {
  const FeedbackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Material(
            color: LoonoColors.buttonLight,
            child: InkWell(
              onTap: () => showFeedbackRatingBottomSheet(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                child: Text(
                  context.l10n.feedback_overlay_button,
                  strutStyle: const StrutStyle(
                    forceStrutHeight: true,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  style: LoonoFonts.paragraphFontStyle.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
