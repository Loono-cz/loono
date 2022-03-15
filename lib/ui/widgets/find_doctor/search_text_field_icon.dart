import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchTextFieldIcon extends StatelessWidget {
  const SearchTextFieldIcon({
    Key? key,
    this.assetPath = 'assets/icons/find_doctor/search.svg',
    this.padding = const EdgeInsets.only(right: 6),
    this.iconWidth,
  }) : super(key: key);

  final String assetPath;
  final EdgeInsets padding;
  final double? iconWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SvgPicture.asset(assetPath, width: iconWidth),
      ),
    );
  }
}
