import 'package:flutter/material.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/l10n/ext.dart';

class FAQPair {
  const FAQPair({
    required this.question,
    required this.answer,
  });

  final String question;
  final String answer;
}

List<FAQPair> faqContent(BuildContext context, ExaminationType type) {
  final texts = context.l10n;
  List<FAQPair> result = [];

  /// NOTE: Not the shortest solution but allows full control over each question and answer
  /// and allows asymmetric content in the future
  switch (type) {
    case ExaminationType.COLONOSCOPY:
      result = [
        FAQPair(
          question: '${texts.what_is} ${type.name}?',
          answer: texts.faq_colonoscopy_answer,
        ),
        FAQPair(
          question: texts.faq_reward_question,
          answer: texts.faq_colonoscopy_reward_answer,
        ),
        FAQPair(
          question: texts.faq_flow_question,
          answer: texts.faq_colonoscopy_flow_answer,
        ),
        FAQPair(
          question: texts.faq_duration_question,
          answer: texts.faq_colonoscopy_duration_answer,
        ),
        FAQPair(
          question: texts.faq_cost_question,
          answer: texts.faq_colonoscopy_cost_answer,
        ),
        FAQPair(
          question: texts.faq_prepare_question,
          answer: texts.faq_colonoscopy_prepare_answer,
        ),
      ];
      break;
    case ExaminationType.DENTIST:
      result = [
        FAQPair(
          question: '${texts.who_is} ${type.name}?',
          answer: texts.faq_dentist_answer,
        ),
        FAQPair(
          question: texts.faq_reward_question,
          answer: texts.faq_dentist_reward_answer,
        ),
        FAQPair(
          question: texts.faq_flow_question,
          answer: texts.faq_dentist_flow_answer,
        ),
        FAQPair(
          question: texts.faq_duration_question,
          answer: texts.faq_dentist_duration_answer,
        ),
        FAQPair(
          question: texts.faq_cost_question,
          answer: texts.faq_dentist_cost_answer,
        ),
        FAQPair(
          question: texts.faq_prepare_question,
          answer: texts.faq_dentist_prepare_answer,
        ),
      ];
      break;
    case ExaminationType.DERMATOLOGIST:
      result = [
        FAQPair(
          question: '${texts.who_is} ${type.name}?',
          answer: texts.faq_dermatologist_answer,
        ),
        FAQPair(
          question: texts.faq_reward_question,
          answer: texts.faq_dermatologist_reward_answer,
        ),
        FAQPair(
          question: texts.faq_flow_question,
          answer: texts.faq_dermatologist_flow_answer,
        ),
        FAQPair(
          question: texts.faq_duration_question,
          answer: texts.faq_dermatologist_duration_answer,
        ),
        FAQPair(
          question: texts.faq_cost_question,
          answer: texts.faq_dermatologist_cost_answer,
        ),
        FAQPair(
          question: texts.faq_prepare_question,
          answer: texts.faq_dermatologist_prepare_answer,
        ),
      ];
      break;
    case ExaminationType.GENERAL_PRACTITIONER:
      result = [
        FAQPair(
          question: '${texts.who_is} ${type.name}?',
          answer: texts.faq_general_practitioner_answer,
        ),
        FAQPair(
            question: texts.faq_reward_question,
            answer: texts.faq_general_practitioner_reward_answer),
        FAQPair(
          question: texts.faq_flow_question,
          answer: texts.faq_general_practitioner_flow_answer,
        ),
        FAQPair(
          question: texts.faq_duration_question,
          answer: texts.faq_general_practitioner_duration_answer,
        ),
        FAQPair(
          question: texts.faq_cost_question,
          answer: texts.faq_general_practitioner_cost_answer,
        ),
        FAQPair(
          question: texts.faq_prepare_question,
          answer: texts.faq_general_practitioner_prepare_answer,
        ),
      ];
      break;
    case ExaminationType.GYNECOLOGIST:
      result = [
        FAQPair(
          question: '${texts.who_is} ${type.name}?',
          answer: texts.faq_gynecologist_answer,
        ),
        FAQPair(
          question: texts.faq_reward_question,
          answer: texts.faq_gynecologist_reward_answer,
        ),
        FAQPair(
          question: texts.faq_flow_question,
          answer: texts.faq_gynecologist_flow_answer,
        ),
        FAQPair(
          question: texts.faq_duration_question,
          answer: texts.faq_gynecologist_duration_answer,
        ),
        FAQPair(
          question: texts.faq_cost_question,
          answer: texts.faq_gynecologist_cost_answer,
        ),
        FAQPair(
          question: texts.faq_prepare_question,
          answer: texts.faq_gynecologist_prepare_answer,
        ),
      ];
      break;
    case ExaminationType.MAMMOGRAM:
      result = [
        FAQPair(
          question: '${texts.what_is} ${type.name}?',
          answer: texts.faq_mammogram_answer,
        ),
        FAQPair(
          question: texts.faq_reward_question,
          answer: texts.faq_mammogram_reward_answer,
        ),
        FAQPair(
          question: texts.faq_flow_question,
          answer: texts.faq_mammogram_flow_answer,
        ),
        FAQPair(
          question: texts.faq_duration_question,
          answer: texts.faq_mammogram_duration_answer,
        ),
        FAQPair(
          question: texts.faq_cost_question,
          answer: texts.faq_mammogram_cost_answer,
        ),
        FAQPair(
          question: texts.faq_prepare_question,
          answer: texts.faq_mammogram_prepare_answer,
        ),
      ];
      break;
    case ExaminationType.OPHTHALMOLOGIST:
      result = [
        FAQPair(
          question: '${texts.who_is} ${type.name}?',
          answer: texts.faq_ophthalmologist_answer,
        ),
        FAQPair(
          question: texts.faq_reward_question,
          answer: texts.faq_ophthalmologist_reward_answer,
        ),
        FAQPair(
          question: texts.faq_flow_question,
          answer: texts.faq_ophthalmologist_flow_answer,
        ),
        FAQPair(
          question: texts.faq_duration_question,
          answer: texts.faq_ophthalmologist_duration_answer,
        ),
        FAQPair(
          question: texts.faq_cost_question,
          answer: texts.faq_ophthalmologist_cost_answer,
        ),
        FAQPair(
          question: texts.faq_prepare_question,
          answer: texts.faq_ophthalmologist_prepare_answer,
        ),
      ];
      break;

    case ExaminationType.UROLOGIST:
      result = [
        FAQPair(
          question: '${texts.who_is} ${type.name}?',
          answer: texts.faq_urologist_answer,
        ),
        FAQPair(
          question: texts.faq_reward_question,
          answer: texts.faq_urologist_reward_answer,
        ),
        FAQPair(
          question: texts.faq_flow_question,
          answer: texts.faq_urologist_flow_answer,
        ),
        FAQPair(
          question: texts.faq_duration_question,
          answer: texts.faq_urologist_duration_answer,
        ),
        FAQPair(
          question: texts.faq_cost_question,
          answer: texts.faq_urologist_cost_answer,
        ),
        FAQPair(
          question: texts.faq_prepare_question,
          answer: texts.faq_urologist_prepare_answer,
        ),
      ];
      break;
    case ExaminationType.BREAST_SELF:
      // TODO: This case is not used yet
      break;
    case ExaminationType.TESTICULAR_SELF:
      // TODO: This case is not used yet
      break;
    case ExaminationType.TOKS:
      // TODO: This case is not used yet
      break;
    case ExaminationType.ULTRASOUND_BREAST:
      // TODO: This case is not used yet
      break;
  }
  return result;
}
