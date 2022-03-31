import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/ui/screens/prevention/self_examination/self_faq_content.dart';

class WidgetExpansionTile extends StatefulWidget {
  const WidgetExpansionTile(
    this.pair, {
    Key? key,
    this.expansionIconKey,
  }) : super(key: key);

  final SelfFAQPair pair;
  final Key? expansionIconKey;

  @override
  State<WidgetExpansionTile> createState() => _WidgetExpansionTileState();
}

class _WidgetExpansionTileState extends State<WidgetExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: LoonoColors.faqBackgroundBlue,
          child: Theme(
            /// remove expansion tile borders
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 10),
              title: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 100),
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: _isExpanded ? FontWeight.w600 : FontWeight.w400,
                  color: LoonoColors.black,
                ),
                child: widget.pair.question,
              ),
              onExpansionChanged: (val) {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              trailing: AnimatedRotation(
                key: widget.expansionIconKey,
                turns: _isExpanded ? .5 : 0,
                duration: const Duration(milliseconds: 200),
                child: SvgPicture.asset('assets/icons/chevron-down.svg'),
              ),
              children: <Widget>[
                ListTile(
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 14,
                              color: LoonoColors.black,
                              height: 1.6,
                            ),
                            child: Flexible(
                              key: const Key('widgetExpansionTile_answer'),
                              child: widget.pair.answer,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  contentPadding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 8,
                  ),
                  dense: true,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
