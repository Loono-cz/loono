import 'package:flutter/material.dart';

class LoonoCloseButton extends StatelessWidget {
  const LoonoCloseButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: IconButton(
        icon: const Icon(Icons.close, size: 32),
        onPressed: onPressed,
      ),
    );
  }
}
