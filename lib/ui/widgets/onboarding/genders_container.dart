import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/onboarding/gender_button.dart';

enum Gender { man, woman, other }

typedef GenderCallback = void Function(Gender genger);

class GendersContainer extends StatefulWidget {
  const GendersContainer({Key? key, this.genderCallBack}) : super(key: key);
  final GenderCallback? genderCallBack;

  @override
  _GendersContainerState createState() => _GendersContainerState();
}

class _GendersContainerState extends State<GendersContainer> {
  Gender? activeButton;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GenderButton(
              active: activeButton == Gender.woman,
              path: 'assets/icons/gender-woman.svg',
              label: 'žena',
              width: 28,
              height: 45,
              onClick: () => setState(() {
                activeButton = Gender.woman;
                widget.genderCallBack!(activeButton!);
              }),
            ),
            GenderButton(
              active: activeButton == Gender.man,
              path: 'assets/icons/gender-man.svg',
              label: 'muž',
              width: 40,
              height: 40,
              onClick: () => setState(() {
                activeButton = Gender.man;
                widget.genderCallBack!(activeButton!);
              }),
            ),
            GenderButton(
              active: activeButton == Gender.other,
              path: 'assets/icons/gender-other.svg',
              label: 'lgbt',
              width: 62,
              height: 65,
              onClick: () => setState(() {
                activeButton = Gender.other;
                widget.genderCallBack!(activeButton!);
              }),
            ),
          ],
        ),
      ],
    );
  }
}
