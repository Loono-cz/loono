import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/consultancy/consultancy_topic.dart';
import 'package:loono/ui/widgets/space.dart';

class ConsultancyCard extends StatelessWidget {
  const ConsultancyCard({Key? key, required this.topic}) : super(key: key);

  final ConsultancyTopic topic;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: LoonoColors.beigeLighter,
      margin: const EdgeInsets.symmetric(horizontal: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        onTap: () {
          // TODO open consultancy screen
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
