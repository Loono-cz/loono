import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/ui/widgets/onboarding/carousel/story_page.dart';

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
    required this.storyPageState,
    required this.duration,
    this.isAnimated = false,
    required this.maxWidth,
    this.height = 4.0,
    required this.indicatorStyle,
    this.onFinish,
  }) : super(key: key);

  final bool finished;
  final StoryPageState storyPageState;
  final Duration duration;
  final bool isAnimated;
  final double maxWidth;
  final double height;
  final IndicatorStyle indicatorStyle;
  final VoidCallback? onFinish;

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
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onFinish?.call();
        }
      });
    containerAnim = Tween<double>(begin: 0.0, end: widget.maxWidth).animate(animationController);
  }

  @override
  void didUpdateWidget(Indicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (animationController.value > 0) {
      if (widget.storyPageState.isPaused != oldWidget.storyPageState.isPaused) {
        oldWidget.storyPageState.isPaused
            ? animationController.forward()
            : animationController.stop();
      } else if (!(widget.storyPageState.isMuted != oldWidget.storyPageState.isMuted)) {
        animationController.reset();
      }
    }

    if (animationController.status == AnimationStatus.completed) {
      if (!(widget.storyPageState.isMuted != oldWidget.storyPageState.isMuted)) {
        animationController.reset();
      }
    }

    if (animationController.duration != widget.duration) {
      animationController
        ..reset()
        ..duration = widget.duration;
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isAnimated) {
      if (!widget.storyPageState.isPaused) {
        animationController.forward();
      }

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
      height: widget.height,
    );
  }
}
