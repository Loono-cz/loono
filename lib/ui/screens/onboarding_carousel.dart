import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/indicator_row.dart';
import 'package:loono/ui/screens/intro_video.dart';

class OnboardingCarouselScreen extends StatefulWidget {
  OnboardingCarouselScreen({Key? key}) : super(key: key);

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
            scrollDirection: Axis.horizontal,
            controller: pageController,
            children: <Widget>[
              Center(
                child: IntroVideoScreen()
              ),
              Center(
                child: Text('Second Page'),
              ),
              Center(
                child: Text('Third Page'),
              ),
              Center(
                child: Text('Fourth Page'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70.0, left: 21.0, right: 21.0),
            child: IndicatorRow(
              currentIndex: pageController.hasClients
                  ? pageController.page?.round() ?? 0
                  : 0,
            ),
          ),
        ],
      ),
    );
  }
}
