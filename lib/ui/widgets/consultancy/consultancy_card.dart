import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/consultancy/form/form_content.dart';
import 'package:loono/ui/widgets/space.dart';

class ConsultancyCard extends StatelessWidget {
  const ConsultancyCard({Key? key, required this.questionType}) : super(key: key);

  const ConsultancyCard.prevention({Key? key})
      : this(questionType: FormQuestionType.preventionAndHealthStyle, key: key);

  const ConsultancyCard.examination({Key? key})
      : this(questionType: FormQuestionType.preventiveExamAndScreening, key: key);

  const ConsultancyCard.selfExamination({Key? key})
      : this(questionType: FormQuestionType.selfExam, key: key);

  final FormQuestionType questionType;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: LoonoColors.beigeLighter,
      margin: const EdgeInsets.symmetric(horizontal: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        onTap: () {
          AutoRouter.of(context).push(FormRoute(initializedType: questionType));
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              const CustomSpacer.horizontal(5),
              SvgPicture.asset(LoonoAssets.consultancyButtonIcon),
              const CustomSpacer.horizontal(15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.consultancy_card_title,
                    style: LoonoFonts.subtitleFontStyle,
                  ),
                  const CustomSpacer.vertical(5),
                  Text(
                    context.l10n.consultancy_card_description,
                    style: LoonoFonts.cardDescription,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
