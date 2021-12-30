import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/onboarding/carousel/app_bar.dart';
import 'package:loono/ui/widgets/onboarding/carousel/button.dart';
import 'package:loono/ui/widgets/onboarding/carousel/carousel_content.dart';

class OnboardingSecondCarouselScreen extends StatelessWidget {
  const OnboardingSecondCarouselScreen({Key? key, this.onNext, this.onBack}) : super(key: key);

  final VoidCallback? onNext;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onBack?.call();
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(237, 248, 253, 1),
        appBar: carouselAppBar(context, onBack),
        body: SafeArea(
          child: CarouselStatContent(
            statText: context.l10n.carousel_content_2_stat,
            highlightPattern: '(${context.l10n.carousel_content_2_stat_highlight})',
            statTextColor: LoonoColors.primaryEnabled,
            bodyText: context.l10n.carousel_content_2_body,
            button: CarouselButton(text: context.l10n.continue_info, onTap: onNext),
            dataSourceText: context.l10n.carousel_content_2_data_source,
          ),
        ),
      ),
    );
  }
}
