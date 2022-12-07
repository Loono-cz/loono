import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/notification_router.dart';
import 'package:loono/ui/widgets/space.dart';

class NotificationLoadingWidget extends StatelessWidget {
  const NotificationLoadingWidget({Key? key, required this.screen}) : super(key: key);

  final NotificationScreen screen;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  LoonoAssets.welcomeLogo,
                ),
                const CustomSpacer.vertical(40),
                Text(
                  context.l10n.notification_loading_header,
                  style: LoonoFonts.headerFontStyle,
                ),
                const CustomSpacer.vertical(15),
                Text(
                  screen == NotificationScreen.examination
                      ? context.l10n.notification_loading_examination
                      : context.l10n.notification_loading_self_examination,
                  style: LoonoFonts.subtitleFontStyle,
                ),
                const CustomSpacer.vertical(40),
                const CircularProgressIndicator(
                  color: LoonoColors.primaryEnabled,
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }
}
