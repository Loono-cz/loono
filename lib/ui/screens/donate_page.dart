import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/close_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({Key? key}) : super(key: key);

  @override
  DonatePageState createState() => DonatePageState();
}

class DonatePageState extends State<DonatePage> {
  Future<void> _closeForm(BuildContext context) async => AutoRouter.of(context).popUntilRoot();

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

          //TODO: set image !
          Image.asset('assets/image_placeholder.png'),
          Text(
            context.l10n.do_you_like_loono,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 24,
            ),
          ),

          Text(
            context.l10n.donate_desc_loono,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),

          ///button
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: LoonoButton(
              text: context.l10n.donate_label_btn,
              onTap: () async {
                if (await canLaunchUrlString(LoonoStrings.donateUrl)) {
                  await launchUrlString(LoonoStrings.donateUrl);
                }
              },
            ),
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
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
                  recognizer: TapGestureRecognizer()..onTap = () => print('Ahoj'),
                  text: context.l10n.notification_settings_edit,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
