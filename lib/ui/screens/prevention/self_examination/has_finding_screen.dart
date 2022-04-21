import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono_api/loono_api.dart';
import 'package:url_launcher/url_launcher.dart';

class HasFindingScreen extends StatelessWidget {
  const HasFindingScreen({Key? key, required this.sex}) : super(key: key);

  final Sex sex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Stack(
                  children: [
                    Positioned(
                      right: -50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(107),
                        child: Container(
                          color: LoonoColors.beigeLighter,
                          width: 207,
                          height: 207,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: IconButton(
                                  key: const Key('hasFindingPage_btn_close'),
                                  onPressed: () =>
                                      AutoRouter.of(context).navigate(const MainRoute()),
                                  icon: const Icon(Icons.close),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  context.l10n.self_examination_has_finding_title,
                                  style: LoonoFonts.headerFontStyle.copyWith(
                                    color: LoonoColors.green,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.l10n.self_examination_has_finding_part_1_title,
                                    style: LoonoFonts.paragraphFontStyle
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    context.l10n.self_examination_has_finding_part_1_desc,
                                    style: LoonoFonts.paragraphFontStyle,
                                  ),
                                  Text(
                                    context.l10n.self_examination_has_finding_part_2_title,
                                    style: LoonoFonts.paragraphFontStyle
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    sex == Sex.MALE
                                        ? context.l10n.self_examination_has_finding_part_2_desc_male
                                        : context
                                            .l10n.self_examination_has_finding_part_2_desc_female,
                                    style: LoonoFonts.paragraphFontStyle,
                                  ),
                                  if (sex == Sex.FEMALE)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: RichText(
                                        text: TextSpan(
                                          text: context.l10n
                                              .self_examination_has_finding_part_2_desc_female_note,
                                          style: LoonoFonts.paragraphFontStyle,
                                          children: [
                                            TextSpan(
                                              text: 'www.mamo.cz',
                                              style: const TextStyle(
                                                color: LoonoColors.primary,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () => launch(
                                                      'https://www.mamo.cz',
                                                    ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    child: Text(
                                      sex == Sex.MALE
                                          ? context.l10n.self_examination_has_finding_part_3_male
                                          : context.l10n.self_examination_has_finding_part_3_female,
                                      style: LoonoFonts.paragraphFontStyle,
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: context.l10n.self_examination_has_finding_part_4,
                                      style: LoonoFonts.paragraphFontStyle,
                                      children: [
                                        TextSpan(
                                          text: context.l10n
                                              .self_examination_has_finding_part_4_doctors_list,
                                          style: const TextStyle(
                                            color: LoonoColors.primary,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => AutoRouter.of(context)
                                                .replace(MainRoute(children: [FindDoctorRoute()])),
                                        )
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: context.l10n.self_examination_has_finding_part_5,
                                      style: LoonoFonts.paragraphFontStyle,
                                      children: [
                                        TextSpan(
                                          text: 'loono@gmail.com',
                                          style: const TextStyle(
                                            color: LoonoColors.primary,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => launch(
                                                  'mailto:loono@gmail.com',
                                                ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: LoonoButton.light(
                                  key: const Key('hasFindingPage_btn_findDoctor'),
                                  text: context.l10n.main_menu_item_find_doc,
                                  onTap: () => AutoRouter.of(context)
                                      .replace(MainRoute(children: [FindDoctorRoute()])),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
