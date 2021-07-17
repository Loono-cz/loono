import 'package:flutter/material.dart';

const _activeColor = Color(0xFF1A1919);
const _underlyingColor = Color(0xFF83898B);

class Indicator extends StatefulWidget {
  const Indicator({
    Key? key,
    this.finished = false,
    this.duration = const Duration(milliseconds: 4000),
    this.shouldAnimate = false,
  }) : super(key: key);

  final bool finished;
  final Duration duration;
  final bool shouldAnimate;

  @override
  _IndicatorState createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> containerAnim;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    containerAnim =
        Tween<double>(begin: 0.0, end: 75.0).animate(animationController);
    animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed && widget.shouldAnimate) {
        // animationController.reset();
        // animationController.reset();
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.shouldAnimate) {
      if (animationController.status == AnimationStatus.completed) {
        animationController.reset();
      }
      animationController.forward();
    }

    return Stack(
      children: [
        buildContainer(),
        widget.finished
            ? buildContainer()
            : AnimatedBuilder(
                animation: containerAnim,
                builder: (BuildContext context, Widget? child) {
                  return buildContainer(
                    width: containerAnim.value,
                    color: _activeColor,
                  );
                },
              ),
      ],
    );
  }

  Container buildContainer({
    Color color = _underlyingColor,
    double width = 75.0,
  }) {
    return Container(
      height: 4.0,
      width: width,
      color: color,
    );
  }
}
