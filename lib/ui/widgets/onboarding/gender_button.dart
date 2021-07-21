import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GenderButton extends StatelessWidget {
  final bool active;
  final String path;
  final String label;
  final double width;
  final double height;
  final void Function() onClick;

  const GenderButton({
    Key? key,
    this.active = false,
    required this.path,
    required this.label,
    required this.width,
    required this.height,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onClick,
      child: Container(
        width: 80,
        height: 120,
        padding: const EdgeInsets.all(5),
        decoration: active
            ? BoxDecoration(
          border: Border.all(color: const Color(0xFFEFAD89)),
          borderRadius: BorderRadius.circular(10),
        )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              path,
              width: width,
              height: height,
              color: active ? const Color(0xFFEFAD89) : const Color(0xFF1A1919),
            ),
            const SizedBox(height: 20),
            Text(
              label,
              style: TextStyle(color: active ? const Color(0xFFEFAD89) : const Color(0xFF1A1919)),
            ),
          ],
        ),
      ),
    );
  }
}
