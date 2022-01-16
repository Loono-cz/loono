import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';

class RecommendationItem extends StatelessWidget {
  const RecommendationItem({Key? key, required this.asset, required this.content})
      : super(key: key);

  final String asset;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 71,
          height: 71,
          decoration: BoxDecoration(
            color: LoonoColors.primary,
            borderRadius: BorderRadius.circular(36),
          ),
          child: Center(
            child: SvgPicture.asset(
              asset,
              width: 26,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Text(content),
        )
      ],
    );
  }
}
