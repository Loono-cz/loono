import 'package:flutter/material.dart';

PreferredSize carouselAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.123),
    child: Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.046),
      child: AppBar(
        iconTheme: Theme.of(context).iconTheme.copyWith(color: const Color.fromRGBO(20, 19, 19, 1)),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        toolbarHeight: 63.0,
      ),
    ),
  );
}
