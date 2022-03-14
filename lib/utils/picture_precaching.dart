import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';

const welcomeSplashes = ['assets/icons/carousel_doctors.svg', 'assets/icons/people.svg'];

Future<void> precacheImagesFromList(List<String> imgRoutes) async {
  await Future.forEach<String>(
    imgRoutes,
    (imgRoute) => precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        imgRoute,
      ),
      null,
    ),
  );
}
