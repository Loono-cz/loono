import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/ui/widgets/space.dart';

class NotificationLoadingScreen extends StatelessWidget {
  const NotificationLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  LoonoAssets.welcomeLogo,
                ),
                const CustomSpacer.vertical(40),
                const CircularProgressIndicator(
                  color: LoonoColors.primaryEnabled,
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async => false
    );
  }
}
