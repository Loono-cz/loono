import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/services/onboarding_state_service.dart';
import 'package:loono/ui/widgets/onboarding/carousel/app_bar.dart';
import 'package:loono/ui/widgets/onboarding/carousel/button.dart';
import 'package:loono/ui/widgets/onboarding/carousel/carousel_content.dart';
import 'package:loono/utils/registry.dart';
import 'package:provider/provider.dart';

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
        backgroundColor: const Color.fromRGBO(241, 249, 249, 1),
        appBar: carouselAppBar(context, onBack),
        body: SafeArea(
          child: CarouselImageContent(
            headerText: context.l10n.carousel_content_3_header,
            bodyText: context.l10n.carousel_content_3_body,
            image: SvgPicture.asset(
              'assets/icons/carousel_doctors.svg',
              width: MediaQuery.of(context).size.width,
            ),
            button: CarouselButton(
              heightMultiplier: 0.11,
              text: context.l10n.carousel_content_3_button,
              onTap: () async {
                await registry.get<UserRepository>().createUser();
                context.read<OnboardingStateService>().startQuestionnaire();
              },
            ),
          ),
        ),
      ),
    );
  }
}
