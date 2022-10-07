import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/faq_content.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/expansion_tile.dart';
import 'package:loono_api/loono_api.dart';

class FaqSection extends StatelessWidget {
  const FaqSection({Key? key, required this.examinationType}) : super(key: key);

  final ExaminationType examinationType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                context.l10n.frequent_questions,
                style: LoonoFonts.headerFontStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: faqContent(context, examinationType)
                .map(
                  FaqExpansionTile.new,
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
