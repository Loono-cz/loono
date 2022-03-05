import 'package:flutter/material.dart';

/// This widget helps to spawn avatar bubble arrow at the same time as bottom sheet overlay is shown
class AvatarBubbleNotifier extends StatefulWidget {
  const AvatarBubbleNotifier({Key? key, required this.convertExtent, required this.child})
      : super(key: key);
  final Function(double?) convertExtent;
  final Widget child;

  @override
  _AvatarBubbleNotifierState createState() => _AvatarBubbleNotifierState();
}

class _AvatarBubbleNotifierState extends State<AvatarBubbleNotifier> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      widget.convertExtent(0.4);
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.convertExtent(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
