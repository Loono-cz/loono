import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/ui/widgets/button.dart';

class AchievementScreen extends StatelessWidget {
  final String imagePath = 'guarantee';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/guarantee.svg"),
              const SizedBox(height: 32),
              const Text("Báječné! Jsi poctivější než polovina žen v Česku"),
              const Text(
                  "Tato prohlídka je důležitá pro včasné odhalení rakoviny děložního čípku a jiných obtíží."),
              const Text('Jen tak dál…'),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/star.svg",
                  ),
                  const SizedBox(width: 4),
                  const Text("200"),
                ],
              ),
              const SizedBox(height: 64),
              LoonoButton(() => {debugPrint("Foo")}, "Pokracovat", true),
            ],
          ),
        ),
      ),
    );
  }
}
