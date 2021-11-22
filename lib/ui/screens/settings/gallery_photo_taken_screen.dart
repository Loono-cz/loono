import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/settings/photo_taken_content.dart';
import 'package:loono/utils/image_utils.dart';

class GalleryPhotoTakenScreen extends StatelessWidget {
  const GalleryPhotoTakenScreen({Key? key, required this.imageBytes}) : super(key: key);

  final Uint8List imageBytes;

  @override
  Widget build(BuildContext context) {
    return PhotoTakenContent(
      imageBytes: imageBytes,
      secondaryButtonText: context.l10n.gallery_photo_picked_again_action,
      onSecondaryButtonTap: () async {
        final result = await takePictureAsBytes(ImageSource.gallery);
        result.fold(
          (error) => showSnackBarError(context, message: error.getMessage(context)),
          (imageBytes) =>
              AutoRouter.of(context).popAndPush(GalleryPhotoTakenRoute(imageBytes: imageBytes)),
        );
      },
    );
  }
}
