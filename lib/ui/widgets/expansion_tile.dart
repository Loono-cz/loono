import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/faq_content.dart';
import 'package:loono/l10n/ext.dart';

class FaqExpansionTile extends StatefulWidget {
  const FaqExpansionTile(this.pair, {Key? key}) : super(key: key);

  final FAQPair pair;

  @override
  State<FaqExpansionTile> createState() => _FaqExpansionTileState();
}

class _FaqExpansionTileState extends State<FaqExpansionTile> {
  bool _isExpanded = false;
  bool _showMore = false;

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
                child: Text(
                  widget.pair.question,
                ),
              ),
              onExpansionChanged: (val) {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              trailing: AnimatedRotation(
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
                          Flexible(
                            child: Text(
                              widget.pair.answer.length > 370 && !_showMore
                                  ? '${widget.pair.answer.substring(0, 370).trim()}...'
                                  : widget.pair.answer,
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (widget.pair.answer.length > 370)
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _showMore = !_showMore;
                                });
                              },
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(0),
                                ),
                                splashFactory: NoSplash.splashFactory,
                              ),
                              child: Text(
                                _showMore
                                    ? context.l10n.less_information
                                    : context.l10n.more_information,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: LoonoColors.green,
                                ),
                              ),
                            ),
                          ],
                        )
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
