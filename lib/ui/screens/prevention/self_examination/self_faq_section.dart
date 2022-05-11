import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/screens/prevention/self_examination/self_faq_content.dart';
import 'package:loono/ui/widgets/widget_expansion_tile.dart';
import 'package:loono_api/loono_api.dart';

class SelfFaqSection extends StatelessWidget {
  const SelfFaqSection({
    Key? key,
    required this.selfExaminationType,
  }) : super(key: key);

  final SelfExaminationType selfExaminationType;

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
            children: selfFaqContent(context, selfExaminationType)
                .mapIndexed(
                  (i, content) => WidgetExpansionTile(
                    content,
                    key: ValueKey('selfFaqSection_item_$i'),
                    expansionIconKey: ValueKey('selfFaqSection_item_expansionIcon_$i'),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
