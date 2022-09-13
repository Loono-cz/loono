import 'package:flutter/material.dart';
import 'package:loono/ui/screens/donate_page.dart';

void showDonateBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => const FractionallySizedBox(
      child: DonatePage(),
    ),
  );
}
