import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/ui/widgets/onboarding/gender_button.dart';
import 'package:loono/l10n/ext.dart';
import 'package:url_launcher/url_launcher.dart';

enum Gender { man, woman, other }

typedef GenderCallback = void Function(Gender? gender);

class GendersContainer extends StatefulWidget {
  const GendersContainer({Key? key, this.genderCallBack}) : super(key: key);
  final GenderCallback? genderCallBack;

  @override
  _GendersContainerState createState() => _GendersContainerState();
}

class _GendersContainerState extends State<GendersContainer> {
  Gender? activeButton;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 4,
              child: GenderButton(
                active: activeButton == Gender.woman,
                path: 'assets/icons/gender-woman.svg',
                label: context.l10n.gender_female,
                width: 28,
                height: 45,
                onClick: () => setState(() {
                  activeButton = Gender.woman;
                  widget.genderCallBack!(activeButton!);
                }),
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 4,
              child: GenderButton(
                active: activeButton == Gender.man,
                path: 'assets/icons/gender-man.svg',
                label: context.l10n.gender_male,
                width: 40,
                height: 40,
                onClick: () => setState(() {
                  activeButton = Gender.man;
                  widget.genderCallBack!(activeButton!);
                }),
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 4,
              child: GenderButton(
                active: activeButton == Gender.other,
                path: 'assets/icons/gender-other.svg',
                label: context.l10n.gender_other,
                width: 28,
                height: 45,
                onClick: () => setState(() {
                  activeButton = Gender.other;
                  widget.genderCallBack!(null);
                  _showInfoSheet();
                }),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showInfoSheet() {
    const linearGradient = LinearGradient(colors: LoonoColors.rainbow);
    const textStyle = TextStyle(color: LoonoColors.black, height: 1.5);

    showModalBottomSheet(
      context: context,
      backgroundColor: LoonoColors.bottomSheetLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.881,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24.0),
                ShaderMask(
                  shaderCallback: (bounds) => linearGradient.createShader(
                    Rect.fromLTWH(0.0, 0.0, bounds.width, bounds.height),
                  ),
                  child: Text(
                    context.l10n.gender_other.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 24.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 35.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 18.0),
                      Text(context.l10n.gender_other_sheet_desc, style: textStyle),
                      const SizedBox(height: 22.0),
                      RichText(
                        text: TextSpan(
                          text: '${context.l10n.gender_other_sheet_contact} ',
                          style: textStyle,
                          children: [
                            TextSpan(
                              text: LoonoStrings.contactEmail,
                              style: textStyle.copyWith(decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  final Uri emailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: LoonoStrings.contactEmail,
                                  );
                                  if (await canLaunch(emailLaunchUri.toString())) {
                                    launch(emailLaunchUri.toString());
                                  }
                                },
                            ),
                            const TextSpan(text: '.', style: textStyle),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
