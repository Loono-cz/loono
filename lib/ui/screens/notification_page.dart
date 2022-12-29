import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/screens/settings/settings_bottom_sheet.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/close_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

enum NotficationType { newsletter, donate }

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key, required this.notficationType}) : super(key: key);
  final NotficationType notficationType;
  @override
  NotificationPageState createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage> {
  Future<void> _closeForm(BuildContext context) async => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: LoonoCloseButton(onPressed: () async => _closeForm(context)),
          ),
          if (widget.notficationType == NotficationType.donate)
            SvgPicture.asset('assets/donate_ilustration.svg')
          else if (widget.notficationType == NotficationType.newsletter)
            SvgPicture.asset('assets/newsletter_illustration.svg'),
          Text(
            (widget.notficationType == NotficationType.donate)
                ? context.l10n.do_you_like_loono
                : context.l10n.newsletter_be_informed,
            style: LoonoFonts.customExamLabel,
            textAlign: TextAlign.center,
          ),

          Text(
            (widget.notficationType == NotficationType.donate)
                ? context.l10n.donate_desc_loono
                : context.l10n.newsletter_desc,
            style: LoonoFonts.spinnerTextOnceTo,
            textAlign: TextAlign.center,
          ),

          ///button
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: LoonoButton(
                text: (widget.notficationType == NotficationType.donate)
                    ? context.l10n.donate_label_btn
                    : context.l10n.newsletter_label_btn,
                onTap: () async {
                  if (await canLaunchUrlString(LoonoStrings.donateUrl)) {
                    await launchUrlString(LoonoStrings.donateUrl);
                  }
                },
              ),
            ),
          ),
          if (widget.notficationType == NotficationType.donate)
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: LoonoFonts.notificationSubText,
                children: [
                  TextSpan(
                    text: context.l10n.donate_anytime,
                  ),
                  const TextSpan(text: '\n\n'),
                  TextSpan(
                    text: context.l10n.donate_info_notification,
                  ),
                  TextSpan(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => showSettingsSheet(
                            context,
                            settingsPage: SettingsPage.SettingsEditPage,
                            expand: true,
                          ),
                    text: context.l10n.notification_settings_edit,
                  )
                ],
              ),
            )
          else if (widget.notficationType == NotficationType.newsletter)
            Text(
              context.l10n.newsletter_edit,
              style: LoonoFonts.spinnerTextOnceTo,
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
