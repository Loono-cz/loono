import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

PreferredSize carouselAppBar(BuildContext context, VoidCallback? onBack) {
  return PreferredSize(
    preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.123),
    child: Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.046),
      child: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        toolbarHeight: 63.0,
        leading: IconButton(
          onPressed: onBack,
          icon: SvgPicture.asset(
            'assets/icons/arrow_back.svg',
          ),
        ),
      ),
    ),
  );
}
