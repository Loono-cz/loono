import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/find_doctor/specialization_chips_list.dart';
import 'package:loono_api/loono_api.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HasFindingScreen extends StatelessWidget {
  const HasFindingScreen({Key? key, required this.sex, required this.examType})
      : super(key: key);

  final Sex sex;
  final SelfExaminationType examType;

  @override
  Widget build(BuildContext context) {
    final strings = _getHasFindingStringsForExamType(examType, sex, context);
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
                                      AutoRouter.of(context)
                                          .navigate(const MainRoute(),),
                                  icon: const Icon(Icons.close),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  strings.title,
                                  style: LoonoFonts.headerFontStyle.copyWith(
                                    color: LoonoColors.green,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildTitle(context),
                                  _buildDescription(context, strings),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: LoonoButton.light(
                                  key: const Key(
                                    'hasFindingPage_btn_findDoctor',
                                  ),
                                  text: context.l10n.main_menu_item_find_doc,
                                  onTap: () =>
                                      AutoRouter.of(context).replace(
                                        MainRoute(
                                          children: [
                                            FindDoctorRoute(
                                              firstSelectedSpecializationName:
                                              getSpecializationBySelfExaminationType(
                                                  examType),
                                            )
                                          ],
                                        ),
                                      ),
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

  Widget _buildTitle(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
          context.l10n.visit_doctor,
          style: LoonoFonts.paragraphFontStyle
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context, _HasFindingStrings strings) {
    final description = strings;
    return Column(
      children: [
        Text(
          description.goToDoctor,
          style: LoonoFonts.paragraphFontStyle,
        ),
        if (examType == SelfExaminationType.BREAST) _buildBreastHelper(context),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Text(
            description.important,
            style: LoonoFonts.paragraphFontStyle,
          ),
        ),
        _buildDoctorFindParagraph(context),
        _buildSendEmailParagraph(context),
      ],
    );
  }

  Widget _buildDoctorFindParagraph(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: context.l10n.self_examination_has_finding_part_4,
        style: LoonoFonts.paragraphFontStyle,
        children: [
          TextSpan(
            text: context.l10n.self_examination_has_finding_part_4_doctors_list,
            style: const TextStyle(
              color: LoonoColors.primary,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () =>
                  AutoRouter.of(context).replace(
                    MainRoute(
                      children: [
                        FindDoctorRoute(
                          firstSelectedSpecializationName:
                          getSpecializationBySelfExaminationType(examType),
                        )
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }

  Widget _buildSendEmailParagraph(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: context.l10n.self_examination_has_finding_part_5,
        style: LoonoFonts.paragraphFontStyle,
        children: [
          TextSpan(
            text: LoonoStrings.contactEmail,
            style: const TextStyle(
              color: LoonoColors.primary,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () =>
                  launchUrlString(
                    'mailto:${LoonoStrings.contactEmail}',
                  ),
          )
        ],
      ),
    );
  }

  Widget _buildBreastHelper(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: RichText(
        text: TextSpan(
          text:
          context.l10n.self_examination_has_finding_part_2_desc_female_note,
          style: LoonoFonts.paragraphFontStyle,
          children: [
            TextSpan(
              text: LoonoStrings.mamoUrl,
              style: const TextStyle(
                color: LoonoColors.primary,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  if (await canLaunchUrlString(LoonoStrings.mamoUrl)) {
                    await launchUrlString(
                      LoonoStrings.mamoUrl,
                    );
                  }
                },
            )
          ],
        ),
      ),
    );
  }
}

class _HasFindingStrings {
  _HasFindingStrings(this.title, this.goToDoctor, this.important);

  final String title;
  final String goToDoctor;
  final String important;
}

_HasFindingStrings _getHasFindingStringsForExamType(SelfExaminationType type,
    Sex sex,
    BuildContext context,) {
  var title = '';
  var goToDoctor = '';
  var important = '';

  switch (type) {
    case SelfExaminationType.BREAST:
      title = context.l10n.self_examination_testicular_breast_has_finding_title;
      goToDoctor = context.l10n.self_examination_has_finding_part_2_desc_breast;
      important = context.l10n.self_examination_has_finding_part_3_breast;
      break;
    case SelfExaminationType.TESTICULAR:
      title = context.l10n.self_examination_testicular_breast_has_finding_title;
      goToDoctor =
          context.l10n.self_examination_has_finding_part_2_desc_testicular;
      important = context.l10n.self_examination_has_finding_part_3_testicular;
      break;
    case SelfExaminationType.SKIN:
      title = context.l10n.self_examination_skin_has_finding_title;
      goToDoctor = context.l10n.self_examination_has_finding_part_2_desc_skin;
      important = sex == Sex.MALE
          ? context.l10n.self_examination_has_finding_part_3_skin_male
          : context.l10n.self_examination_has_finding_part_3_skin_female;
      break;
  }

  return _HasFindingStrings(title, goToDoctor, important);
}
