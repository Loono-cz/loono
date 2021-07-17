import 'package:flutter/material.dart';

class ExtendedInkWell extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  // Material
  final Clip clip;
  final BorderRadius? borderRadius;
  final ShapeBorder? shape;
  final Color? materialColor;
  final Color? materialShadowColor;

  // InkWell
  final Color? splashColor;
  final Color? highlightColor;

  const ExtendedInkWell(
      {required this.child,
      required this.onTap,
      this.onLongPress,
      this.clip = Clip.antiAlias,
      this.borderRadius,
      this.shape,
      this.materialColor,
      this.materialShadowColor,
      this.splashColor,
      this.highlightColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: clip,
      borderRadius: borderRadius,
      shape: shape,
      color: materialColor ?? Colors.transparent,
      shadowColor: materialShadowColor ?? Colors.transparent,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        splashColor: splashColor ?? Colors.grey.withOpacity(0.5),
        highlightColor: highlightColor ?? Colors.transparent,
        child: child,
      ),
    );
  }
}
