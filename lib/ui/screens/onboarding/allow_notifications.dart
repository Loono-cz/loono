import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/extend_inkwell.dart';
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
              SkipButton(onPressed: () => {}), // TODO: Navigate to Dentist Screen
              const SizedBox(height: 48.0),
              SvgPicture.asset("assets/icons/notification_bell.svg"),
              const SizedBox(height: 53.15),
              _buildDescription(context),
              const Spacer(),
              _buildAllowNotificationButton(context),
              const SizedBox(height: 122.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      context.l10n.notification_allow_desc,
      textAlign: TextAlign.center,
      style: const TextStyle(color: LoonoColors.black, fontSize: 16.0),
    );
  }

  Widget _buildAllowNotificationButton(BuildContext context) {
    return ExtendedInkWell(
      onTap: () {
        // TODO: Display and handle allow notification dialog (iOS only)
        // TODO: Then navigate to Dentist Screen
      },
      materialColor: LoonoColors.primaryEnabled,
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: SizedBox(
        height: 65,
        child: Align(
          child: Text(
            context.l10n.notification_allow_button,
            style: Theme.of(context).textTheme.button?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
