import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/skip_button.dart';

class AllowNotificationsScreen extends StatelessWidget {
  const AllowNotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              const SizedBox(height: 27.0),
              SkipButton(
                text: context.l10n.skip,
                onPressed: () => Navigator.pushNamed(context, '/onboarding/doctor/gynecology'),
              ),
              const SizedBox(height: 48.0),
              SvgPicture.asset("assets/icons/notification_bell.svg", width: 128.0),
              const SizedBox(height: 53.15),
              Text(
                context.l10n.notification_allow_desc,
                textAlign: TextAlign.center,
                style: const TextStyle(color: LoonoColors.black, fontSize: 16.0),
              ),
              const Spacer(),
              LoonoButton(
                text: context.l10n.notification_allow_button,
                onTap: () {
                  // TODO: Display and handle allow notification dialog (iOS only)
                  Navigator.pushNamed(context, '/onboarding/doctor/gynecology');
                },
              ),
              const SizedBox(height: 122.0),
            ],
          ),
        ),
      ),
    );
  }
}
