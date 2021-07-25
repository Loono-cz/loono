import 'package:flutter/material.dart';
import 'package:loono/constants.dart';

class IndicatorStyle {
  const IndicatorStyle({
    required this.activeColor,
    required this.underlyingColor,
  });

  factory IndicatorStyle.light() => const IndicatorStyle(
        activeColor: LoonoColors.storyIndicatorActiveLight,
        underlyingColor: LoonoColors.storyIndicatorUnderlyingLight,
      );

  factory IndicatorStyle.dark() => const IndicatorStyle(
        activeColor: LoonoColors.storyIndicatorActiveDark,
        underlyingColor: LoonoColors.storyIndicatorUnderlyingDark,
      );

  final Color activeColor;
  final Color underlyingColor;
}

class Indicator extends StatefulWidget {
  const Indicator({
    Key? key,
    this.finished = false,
    required this.duration,
    this.shouldAnimate = false,
    required this.maxWidth,
    required this.indicatorStyle,
  }) : super(key: key);

  final bool finished;
  final Duration duration;
  final bool shouldAnimate;
  final double maxWidth;
  final IndicatorStyle indicatorStyle;

  @override
  _IndicatorState createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> containerAnim;

  IndicatorStyle get indicatorStyle => widget.indicatorStyle;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    containerAnim = Tween<double>(begin: 0.0, end: widget.maxWidth).animate(animationController);
  }

  @override
  void didUpdateWidget(Indicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (animationController.duration != widget.duration) {
      animationController.duration = widget.duration;
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.shouldAnimate) {
      animationController
        ..reset()
        ..forward();

      return Stack(
        children: [
          buildContainer(width: widget.maxWidth, color: indicatorStyle.underlyingColor),
          AnimatedBuilder(
            animation: containerAnim,
            builder: (_, __) {
              return buildContainer(width: containerAnim.value, color: indicatorStyle.activeColor);
            },
          ),
        ],
      );
    }

    if (widget.finished) {
      return buildContainer(width: widget.maxWidth, color: indicatorStyle.activeColor);
    }

    return buildContainer(width: widget.maxWidth, color: indicatorStyle.underlyingColor);
  }

  Container buildContainer({
    required Color color,
    required double width,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: color,
      ),
      width: width,
      height: 4.0,
    );
  }
}
