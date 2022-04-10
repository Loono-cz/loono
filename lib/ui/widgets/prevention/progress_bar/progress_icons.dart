import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/ui/widgets/prevention/progress_bar/mini_progress_ring.dart';

class SuccessIcon extends StatelessWidget {
  const SuccessIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: LoonoColors.greenSuccess,
        borderRadius: BorderRadius.circular(9),
      ),
      child: const Icon(
        Icons.check,
        size: 14,
        color: Colors.white,
      ),
    );
  }
}

class EmptyIcon extends StatelessWidget {
  const EmptyIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        border: Border.all(width: 2, color: LoonoColors.primaryWashed),
      ),
    );
  }
}

class ProgressIcon extends StatelessWidget {
  const ProgressIcon({Key? key, required this.progress}) : super(key: key);

  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18,
      height: 18,
      child: CustomPaint(
        painter: MiniProgressRing(
          backgroundColor: LoonoColors.primaryWashed,
          progress: progress,
        ),
      ),
    );
  }
}
