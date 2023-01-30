import 'package:flutter/material.dart';
import 'package:loono/ui/screens/notification_page.dart';

class OnboardingSecondCarouselScreen extends StatelessWidget {
  const OnboardingSecondCarouselScreen({Key? key, this.onNext, this.onBack}) : super(key: key);

  final VoidCallback? onNext;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(237, 248, 253, 1),
      body: SafeArea(
        child: NotificationPage(
          key: key,
          notficationType: NotficationType.newsletter,
        ),
      ),
    );
  }
}
