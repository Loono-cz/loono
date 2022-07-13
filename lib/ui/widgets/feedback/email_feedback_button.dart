import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EmailFeedbackButton extends StatelessWidget {
  const EmailFeedbackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final emailLaunchUri = Uri(scheme: 'mailto', path: LoonoStrings.contactEmail);
        if (await canLaunchUrlString(emailLaunchUri.toString())) {
          await launchUrlString(emailLaunchUri.toString());
        }
      },
      child: Text(
        context.l10n.feedback_form_button_email,
        style: LoonoFonts.fontStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
