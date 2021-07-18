import 'package:flutter/material.dart';
import 'package:loono/ui/screens/onboarding/carousel/carousel_fourth.dart';
import 'package:loono/ui/screens/onboarding/carousel/carousel_second.dart';
import 'package:loono/ui/screens/onboarding/carousel/carousel_third.dart';
import 'package:loono/ui/widgets/indicator_row.dart';
import 'package:loono/ui/widgets/intro_video.dart';

class OnboardingCarouselScreen extends StatefulWidget {
  const OnboardingCarouselScreen({Key? key}) : super(key: key);

  @override
  _OnboardingCarouselScreenState createState() => _OnboardingCarouselScreenState();
}

class _OnboardingCarouselScreenState extends State<OnboardingCarouselScreen> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (_) => setState(() {}),
            controller: pageController,
            children: <Widget>[
              Scaffold(body: Center(child: IntroVideo())),
              OnboardingSecondCarouselScreen(),
              OnboardingThirdCarouselScreen(),
              OnboardFourthCarouselScreen(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70.0, left: 21.0, right: 21.0),
            child: IndicatorRow(
              currentIndex: pageController.hasClients ? pageController.page?.round() ?? 0 : 0,
            ),
          ),
        ],
      ),
    );
  }
}
