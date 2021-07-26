import 'package:flutter/material.dart';
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
