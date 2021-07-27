import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/ui/widgets/carousel_content_widget.dart';

class OnboardFourthCarouselScreen extends StatelessWidget {
  const OnboardFourthCarouselScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(241, 249, 249, 1),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: CarouselContentWidget(
            text: 'Staneš se skutečným hrdinou / hrdinkou svého života.',
          ),
        ),
      ),
    );
  }
}

class OnboardFourthCarouselInteractiveContent extends StatelessWidget {
  const OnboardFourthCarouselInteractiveContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 120.0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: TextButton(
          style: ButtonStyle(
            alignment: Alignment.center,
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(LoonoColors.primary),
          ),
          onPressed: () => Navigator.pushNamed(context, '/onboarding/gender'),
          child: const Text('Beru zdraví do svých rukou'),
        ),
      ),
    );
  }
}
