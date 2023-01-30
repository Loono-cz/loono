import 'package:flutter/material.dart';
import 'package:loono/ui/screens/notification_page.dart';

void showBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => const FractionallySizedBox(
      child: NotificationPage(
        notficationType: NotficationType.newsletter,
      ),
    ),
  );
}
