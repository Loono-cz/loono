import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/feedback/feedback_form_content_sheet.dart';
import 'package:loono/ui/widgets/feedback/rating_bar.dart';

void showFeedbackRatingBottomSheet(BuildContext pageContext) {
  final l10n = pageContext.l10n;
  final borderRadius = BorderRadius.circular(10.0);
  final ratingValueNotifier = ValueNotifier<int?>(null);

  showModalBottomSheet<void>(
    context: pageContext,
    shape: RoundedRectangleBorder(borderRadius: borderRadius),
    isScrollControlled: true,
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: LoonoSizes.isScreenSmall(context) ? 0.63 : 0.53,
        child: Container(
          decoration: BoxDecoration(
            color: LoonoColors.bottomSheetPrevention,
            borderRadius: borderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: const Icon(Icons.close, size: 32),
                      onPressed: () => AutoRouter.of(context).pop(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(l10n.feedback_form_button_sheet_header, style: LoonoFonts.headerFontStyle),
                const Spacer(flex: 2),
                RatingBar(
                  onChanged: (rating) {
                    if (rating >= 1 && rating <= 5) {
                      ratingValueNotifier.value = rating;
                    }
                  },
                ),
                const Spacer(flex: 2),
                ValueListenableBuilder<int?>(
                  valueListenable: ratingValueNotifier,
                  builder: (context, ratingValue, _) {
                    return LoonoButton(
                      enabled: ratingValue != null,
                      text: l10n.continue_info,
                      onTap: () => showFeedbackFormContentBottomSheet(
                        pageContext,
                        rating: ratingValue!,
                      ),
                    );
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      );
    },
  );
}
