import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/onboarding_state_service.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/skip_button.dart';
import 'package:loono/ui/widgets/space.dart';
import 'package:provider/provider.dart';

class AllowNotificationsScreen extends StatelessWidget {
  const AllowNotificationsScreen({
    Key? key,
    this.onSkipTap,
    this.onContinueTap,
  }) : super(key: key);

  final VoidCallback? onSkipTap;
  final VoidCallback? onContinueTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              const CustomSpacer.vertical(20),
              SkipButton(
                text: context.l10n.skip_notification,
                onPressed: onSkipTap ??
                    () => context.read<OnboardingStateService>().skipPermissionRequest(),
              ),
              const Spacer(),
              SvgPicture.asset(
                LoonoAssets.notificationBells,
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              const Spacer(),
              Text(
                context.l10n.notification_allow_desc,
                textAlign: TextAlign.center,
                style: const TextStyle(color: LoonoColors.black, fontSize: 16.0),
              ),
              const Spacer(),
              LoonoButton(
                text: context.l10n.notification_allow_button,
                onTap: onContinueTap ??
                    () async => context.read<OnboardingStateService>().promptPermission(),
              ),
              SizedBox(height: LoonoSizes.buttonBottomPadding(context)),
            ],
          ),
        ),
      ),
    );
  }
}
