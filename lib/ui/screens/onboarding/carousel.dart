import 'package:flutter/material.dart';
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
              const Scaffold(
                body: Center(
                  child: Text('Second Page'),
                ),
              ),
              const Scaffold(
                body: Center(
                  child: Text('Third Page'),
                ),
              ),
              Scaffold(
                body: Column(
                  children: [
                    const Text('Fourth Page'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/onboarding/gender');
                      },
                      child: const Text('pokracovat'),
                    )
                  ],
                ),
              ),
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
