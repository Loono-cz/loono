import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';

class FaqExpansionTile extends StatefulWidget {
  @override
  State<FaqExpansionTile> createState() => _FaqExpansionTileState();
}

class _FaqExpansionTileState extends State<FaqExpansionTile> {
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
                child: const Text(
                  'Title expansion tile',
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
              children: const <Widget>[
                ListTile(
                  title: Text(
                    'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In dapibus augue non sapien. Fusce aliquam vestibulum ipsum. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Etiam neque.',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
