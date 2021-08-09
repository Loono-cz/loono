import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/onboarding/carousel/app_bar.dart';
import 'package:loono/ui/widgets/onboarding/carousel/button.dart';
import 'package:loono/ui/widgets/onboarding/carousel/carousel_content.dart';

class OnboardingThirdCarouselScreen extends StatelessWidget {
  const OnboardingThirdCarouselScreen({Key? key, this.onNext, this.onBack}) : super(key: key);

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
        backgroundColor: const Color.fromRGBO(252, 237, 237, 1),
        appBar: carouselAppBar(context),
        body: SafeArea(
          child: CarouselStatContent(
            statText: context.l10n.carousel_content_3_stat,
            statTextColor: const Color.fromRGBO(59, 126, 129, 1),
            bodyText: context.l10n.carousel_content_3_body,
            button: CarouselButton(text: context.l10n.carousel_content_3_button, onTap: onNext),
          ),
        ),
      ),
    );
  }
}
