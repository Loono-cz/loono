import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/sex_extensions.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/onboarding/gender_button.dart';
import 'package:url_launcher/url_launcher.dart';

enum Gender { man, woman, other }

typedef GenderCallback = void Function(Sex? gender);

class GendersContainer extends StatefulWidget {
  const GendersContainer({
    Key? key,
    this.genderCallBack,
    this.initialActiveButton,
    this.bottomSheetColor = LoonoColors.bottomSheetLight,
  }) : super(key: key);

  final GenderCallback? genderCallBack;
  final Gender? initialActiveButton;
  final Color bottomSheetColor;

  @override
  _GendersContainerState createState() => _GendersContainerState();
}

class _GendersContainerState extends State<GendersContainer> {
  PersistentBottomSheetController? sheetController;

  Gender? activeButton;

  @override
  void initState() {
    super.initState();
    activeButton = widget.initialActiveButton;
  }

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
                  widget.genderCallBack!(Sex.female);
                  _closeSheet();
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
                  widget.genderCallBack!(Sex.male);
                  _closeSheet();
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

    sheetController = Scaffold.of(context).showBottomSheet(
      (context) {
        return FractionallySizedBox(
          heightFactor: MediaQuery.of(context).size.height > 750 ? 0.37 : 0.441,
          child: Container(
            decoration: BoxDecoration(
              color: widget.bottomSheetColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
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
          ),
        );
      },
    );
  }

  void _closeSheet() {
    if (sheetController != null) {
      sheetController!.close();
      sheetController = null;
    }
  }
}
