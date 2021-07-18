import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/carousel_content_widget.dart';

class CarouselScreenThird extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(241, 249, 249, 1),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CarouselContentWidget(
              text: 'Staneš se skutečným hrdinou / hrdinkou svého života.',
              button: Padding(
                  padding: const EdgeInsets.only(bottom: 120.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    width: double.infinity,
                    child: TextButton(
                      style: ButtonStyle(
                        alignment: Alignment.center,
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(239, 173, 137, 1)),
                      ),
                      onPressed: () {},
                      child: Text('Beru zdraví do svých rukou'),
                    ),
                  ))),
        )));
  }
}
