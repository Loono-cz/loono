import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/carousel_content_widget.dart';

class CarouselScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 248, 253, 1),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CarouselContentWidget(
                  text: 'Prodloužíš si život v\nprůměru o 20 let.',
                  image: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/carousel-image-2.png'),
                    ],
                  ),
                ))));
  }
}
