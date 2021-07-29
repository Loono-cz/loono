import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/carousel_content_widget.dart';
import 'package:loono/l10n/ext.dart';

class OnboardingThirdCarouselScreen extends StatelessWidget {
  const OnboardingThirdCarouselScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(252, 237, 237, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CarouselContentWidget(
            text: context.l10n.carousel_content_experience_relief,
            image: Row(
              children: [
                Image.asset('assets/images/carousel-image-3.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
