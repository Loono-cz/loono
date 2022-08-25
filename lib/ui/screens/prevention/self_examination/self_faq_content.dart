import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono_api/loono_api.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SelfFAQPair {
  const SelfFAQPair({
    required this.question,
    required this.answer,
  });

  final Widget question;
  final Widget answer;
}

List<SelfFAQPair> selfFaqContent(BuildContext context, SelfExaminationType type) {
  final texts = context.l10n;
  var result = <SelfFAQPair>[];

  /// NOTE: Not the shortest solution but allows full control over each question and answer
  /// and allows asymmetric content in the future
  switch (type) {
    case SelfExaminationType.TESTICULAR:
      result = [
        SelfFAQPair(
          question: Row(
            children: [
              const Icon(
                Icons.info,
                color: LoonoColors.grey,
                size: 18,
              ),
              const SizedBox(
                width: 6,
              ),
              Text(texts.self_faq_testicular_steps_question),
            ],
          ),
          answer: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                texts.self_faq_dont_be_shy_panic_answer_part_1,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                texts.self_faq_dont_be_shy_panic_answer_part_2,
              ),
              Text(
                texts.visit_doctor_right_now,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                texts.self_faq_testicular_steps_answer_part_4,
              ),
              RichText(
                text: TextSpan(
                  text: '',
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: texts.self_faq_testicular_steps_answer_part_5,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: texts.self_faq_testicular_steps_answer_part_6,
                    ),
                    TextSpan(text: texts.self_faq_testicular_steps_answer_part_7),
                    TextSpan(
                      text: texts.doctor_list,
                      style: const TextStyle(decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => AutoRouter.of(context)
                            .replace(MainRoute(children: [FindDoctorRoute()])),
                    ),
                    TextSpan(text: texts.self_faq_testicular_steps_answer_part_9),
                    TextSpan(
                      text: LoonoStrings.contactEmail,
                      style: const TextStyle(decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          final emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: LoonoStrings.contactEmail,
                          );
                          if (await canLaunchUrlString(emailLaunchUri.toString())) {
                            await launchUrlString(emailLaunchUri.toString());
                          }
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SelfFAQPair(
          question: Text(texts.self_faq_testicular_changes_question),
          answer: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(texts.self_faq_testicular_changes_answer),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ImageTile(
                    assetPath: 'assets/icons/prevention/findings/testicular_shape.svg',
                    description: texts.self_faq_testicular_tile_desc_shape,
                    isMale: true,
                  ),
                  _ImageTile(
                    assetPath: 'assets/icons/prevention/findings/testicular_size.svg',
                    description: texts.self_faq_testicular_tile_desc_size,
                    isMale: true,
                  ),
                  _ImageTile(
                    assetPath: 'assets/icons/prevention/findings/testicular_bump.svg',
                    description: texts.self_faq_testicular_tile_desc_bump,
                    isMale: true,
                  ),
                  _ImageTile(
                    assetPath: 'assets/icons/prevention/findings/testicular_skin.svg',
                    description: texts.self_faq_testicular_tile_desc_skin,
                    isMale: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                children: [
                  Flexible(child: Text(texts.self_faq_testicular_changes2_answer)),
                ],
              ),
            ],
          ),
        ),
        SelfFAQPair(
          question: Text(texts.self_faq_testicular_meaning_question),
          answer: Text(texts.self_faq_testicular_meaning_answer),
        ),
        SelfFAQPair(
          question: Text(texts.self_faq_testicular_ashamed_question),
          answer: Text(texts.self_faq_testicular_ashamed_answer),
        ),
        SelfFAQPair(
          question: Text(texts.self_faq_testicular_distinguish_question),
          answer: Text(texts.self_faq_testicular_distinguish_answer),
        ),
      ];
      break;
    case SelfExaminationType.BREAST:
      result = [
        SelfFAQPair(
          question: Row(
            children: [
              const Icon(
                Icons.info,
                color: LoonoColors.grey,
                size: 18,
              ),
              const SizedBox(
                width: 6,
              ),
              Text(texts.self_faq_what_to_do_if_i_find_something_question),
            ],
          ),
          answer: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                texts.self_faq_breast_steps_answer_part_1,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                texts.self_faq_breast_steps_answer_part_2,
              ),
              Text(
                texts.visit_doctor,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              RichText(
                text: TextSpan(
                  text: '',
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(text: texts.self_faq_breast_steps_answer_part_4),
                    TextSpan(
                      text: 'www.mamo.cz',
                      style: const TextStyle(decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          const url = 'https://www.mamo.cz/';

                          if (await canLaunchUrlString(url)) {
                            await launchUrlString(url);
                          }
                        },
                    ),
                    TextSpan(text: texts.self_faq_breast_steps_answer_part_5),
                    TextSpan(
                      text: texts.self_faq_important,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: texts.self_faq_breast_steps_answer_part_7,
                    ),
                    TextSpan(
                      text: texts.doctor_list,
                      style: const TextStyle(decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => AutoRouter.of(context)
                            .replace(MainRoute(children: [FindDoctorRoute()])),
                    ),
                    TextSpan(
                      text: texts.self_faq_breast_steps_answer_part_9,
                    ),
                    TextSpan(
                      text: LoonoStrings.contactEmail,
                      style: const TextStyle(decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          final emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: LoonoStrings.contactEmail,
                          );
                          if (await canLaunchUrlString(emailLaunchUri.toString())) {
                            await launchUrlString(emailLaunchUri.toString());
                          }
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SelfFAQPair(
          question: Text(texts.self_faq_breast_changes_question),
          answer: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(texts.self_faq_breast_changes_answer),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ImageTile(
                    assetPath: 'assets/icons/prevention/findings/breast_efflux.svg',
                    description: texts.self_faq_breast_tile_desc_flux,
                  ),
                  _ImageTile(
                    assetPath: 'assets/icons/prevention/findings/breast_skin.svg',
                    description: texts.self_faq_breast_tile_desc_skin,
                  ),
                  _ImageTile(
                    assetPath: 'assets/icons/prevention/findings/breast_nipple.svg',
                    description: texts.self_faq_breast_tile_desc_nipple,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ImageTile(
                    assetPath: 'assets/icons/prevention/findings/breast_shape.svg',
                    description: texts.self_faq_breast_tile_desc_shape,
                  ),
                  _ImageTile(
                    assetPath: 'assets/icons/prevention/findings/breast_size.svg',
                    description: texts.self_faq_breast_tile_desc_size,
                  ),
                  const SizedBox(
                    width: 88,
                  )
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                children: [
                  Flexible(child: Text(texts.self_faq_breast_changes2_answer)),
                ],
              ),
            ],
          ),
        ),
        SelfFAQPair(
          question: Text(texts.self_faq_breast_meaning_question),
          answer: Text(texts.self_faq_breast_meaning_answer),
        ),
        SelfFAQPair(
          question: Text(texts.self_faq_breast_distinguish_question),
          answer: Text(texts.self_faq_breast_distinguish_answer),
        ),
        SelfFAQPair(
          question: Text(texts.self_faq_breast_family_question),
          answer: Text(texts.self_faq_breast_family_answer),
        ),
        SelfFAQPair(
          question: Text(texts.self_faq_breast_men_too_question),
          answer: Text(texts.self_faq_breast_men_too_answer),
        ),
      ];
      break;
    case SelfExaminationType.SKIN:
      result = [
        // First question
        SelfFAQPair(
          question: Row(
            children: [
              const Icon(
                Icons.info,
                color: LoonoColors.grey,
                size: 18,
              ),
              const SizedBox(
                width: 6,
              ),
              Text(texts.self_faq_what_to_do_if_i_find_something_question),
            ],
          ),
          answer: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Nepnaikar nestyd se
              Text(
                texts.self_faq_dont_be_shy_panic_answer_part_1,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                texts.self_faq_dont_be_shy_panic_answer_part_2,
              ),
              //Navstiv lekare
              Text(
                texts.visit_doctor_right_now,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              RichText(
                text: TextSpan(
                  text: '',
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    //Call 911/Lekari :D
                    TextSpan(text: texts.self_faq_skin_steps_answer_part_4),
                    const TextSpan(text: '\n\n'),

                    //Dulezite
                    TextSpan(
                      text: texts.self_faq_important,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: texts.self_faq_skin_steps_answer_part_6,
                    ),
                    const TextSpan(text: '\n\n'),
                    TextSpan(
                      text: texts.self_faq_skin_steps_answer_part_7,
                    ),
                    TextSpan(
                      text: texts.doctor_list,
                      style: const TextStyle(decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => AutoRouter.of(context)
                            .replace(MainRoute(children: [FindDoctorRoute()])),
                    ),
                    TextSpan(
                      text: texts.self_faq_breast_steps_answer_part_9,
                    ),
                    TextSpan(
                      text: LoonoStrings.contactEmail,
                      style: const TextStyle(decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          final emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: LoonoStrings.contactEmail,
                          );
                          if (await canLaunchUrlString(emailLaunchUri.toString())) {
                            await launchUrlString(emailLaunchUri.toString());
                          }
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Second question
        SelfFAQPair(
          question: Text(texts.self_faq_skin_changes_question),
          answer: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                texts.self_faq_skin_changes_answer,
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _ImageTile(
                    assetPath: 'assets/icons/prevention/findings/skin_asymetry.svg',
                    description: '(A)symmetry',
                  ),
                  _ImageTile(
                    assetPath: 'assets/icons/prevention/findings/skin_border.svg',
                    description: '(B)order',
                  ),
                  _ImageTile(
                    assetPath: 'assets/icons/prevention/findings/skin_colour.svg',
                    description: '(C)olour',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _ImageTile(
                    assetPath: 'assets/icons/prevention/findings/skin_diameter.svg',
                    description: '(D)iameter',
                  ),
                  _ImageTile(
                    assetPath: 'assets/icons/prevention/findings/skin_evolution.svg',
                    description: '(E)volution',
                  ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    //Asymetricky
                    TextSpan(text: texts.self_faq_skin_title_des_symetry),
                    const TextSpan(text: '\n\n'),
                    //Border
                    TextSpan(
                      text: texts.self_faq_skin_title_des_border,
                    ),
                    const TextSpan(text: '\n\n'),
                    TextSpan(
                      text: texts.self_faq_skin_title_des_colour,
                    ),
                    const TextSpan(text: '\n\n'),
                    TextSpan(
                      text: texts.self_faq_skin_title_des_diametry,
                    ),
                    const TextSpan(text: '\n\n'),
                    TextSpan(
                      text: texts.self_faq_skin_title_des_evolution,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                children: [
                  Flexible(child: Text(texts.self_faq_skin_changes2_answer)),
                ],
              ),
            ],
          ),
        ),

        //Third question
        SelfFAQPair(
          question: Text(texts.self_faq_skin_third_question),
          answer: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: texts.melanom,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: texts.self_faq_skin_third_question_answer_melanom),
                    const TextSpan(text: '\n\n'),
                    TextSpan(
                      text: texts.other_tumors,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: texts.self_faq_skin_third_question_answer_other_tumors),
                  ],
                ),
              )
            ],
          ),
        ),
        //Fourth question
        SelfFAQPair(
          question: Text(texts.self_faq_skin_prevention_question),
          answer: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(texts.self_faq_skin_prevention_answer),
              const SizedBox(
                height: 14,
              ),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: texts.self_faq_skin_prevention_answer1_bold,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: texts.self_faq_skin_prevention_answer1),
                    const TextSpan(text: '\n\n'),
                    TextSpan(
                      text: texts.self_faq_skin_prevention_answer2_bold,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: texts.self_faq_skin_prevention_answer2),
                    const TextSpan(text: '\n\n'),
                    TextSpan(
                      text: texts.self_faq_skin_prevention_answer3_bold,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: texts.self_faq_skin_prevention_answer3),
                    const TextSpan(text: '\n\n'),
                    TextSpan(
                      text: texts.self_faq_skin_prevention_answer4_bold,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: texts.self_faq_skin_prevention_answer4),
                    const TextSpan(text: '\n\n'),
                    TextSpan(
                      text: texts.self_faq_skin_prevention_answer5,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: '\n\n'),
                    TextSpan(
                      text: texts.self_faq_skin_prevention_answer6_bold,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: texts.self_faq_skin_prevention_answer6),
                    const TextSpan(text: '\n\n'),
                    TextSpan(
                      text: texts.self_faq_skin_prevention_answer7_bold,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: texts.self_faq_skin_prevention_answer7),
                    const TextSpan(text: '\n\n'),
                    TextSpan(
                      text: texts.self_faq_skin_prevention_answer8_bold,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: texts.self_faq_skin_prevention_answer8)
                  ],
                ),
              )
            ],
          ),
        )
      ];
      break;
  }
  return result;
}

class _ImageTile extends StatelessWidget {
  const _ImageTile({
    Key? key,
    required this.assetPath,
    required this.description,
    this.isMale = false,
  }) : super(key: key);

  final String assetPath;
  final String description;
  final bool isMale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 69,
            height: 69,
            decoration: BoxDecoration(
              color: LoonoColors.leaderboardPrimary,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: SvgPicture.asset(
                assetPath,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: Text(
              description,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
