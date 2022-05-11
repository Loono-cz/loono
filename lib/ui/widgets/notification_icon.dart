import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationIcon extends StatelessWidget {
  /// A red circle icon with exclamation mark.
  const NotificationIcon.topPriority({Key? key, this.width})
      : _assetName = 'appointment_soon',
        super(key: key);

  /// Just a red circle icon.
  const NotificationIcon.priority({Key? key, this.width})
      : _assetName = 'make_an_appointment',
        super(key: key);

  final String _assetName;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/prevention/$_assetName.svg',
      width: width,
    );
  }
}
