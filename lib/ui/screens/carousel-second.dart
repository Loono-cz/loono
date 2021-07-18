import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/carousel_content_widget.dart';

class CarouselScreenSecond extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(252, 237, 237, 1),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CarouselContentWidget(
                  text: 'Zažiješ úlevu, že jsi nic nezanedbal/a.',
                  image: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/carousel-image-3.png'),
                    ],
                  ),
                ))));
  }
}
