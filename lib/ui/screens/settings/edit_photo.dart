import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/routers/app_router.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/settings/app_bar.dart';
import 'package:loono/ui/widgets/settings/avatar.dart';
import 'package:loono/utils/image_utils.dart';

class EditPhotoScreen extends StatelessWidget {
  const EditPhotoScreen({Key? key, this.imageBytes}) : super(key: key);

  // TODO: Remove this parameter once uploading profile image to Firebase is done
  final Uint8List? imageBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: settingsAppBar(context),
      backgroundColor: LoonoColors.settingsBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(context.l10n.photo_header, style: const TextStyle(fontSize: 24)),
              ),
              const Spacer(),
              LoonoAvatar(radius: MediaQuery.of(context).size.width * 0.3, imageBytes: imageBytes),
              const Spacer(flex: 2),
              LoonoButton.light(
                text: context.l10n.edit_photo_take_camera_picture_action,
                onTap: () async {
                  final result = await takePictureAsBytes(ImageSource.camera);
                  result.fold(
                    (error) => showSnackBarError(context, message: error.getMessage(context)),
                    (imageBytes) =>
                        AutoRouter.of(context).push(CameraPhotoTakenRoute(imageBytes: imageBytes)),
                  );
                },
              ),
              const SizedBox(height: 20),
              LoonoButton.light(
                text: context.l10n.edit_photo_pick_gallery_picture_action,
                onTap: () async {
                  final result = await takePictureAsBytes(ImageSource.gallery);
                  result.fold(
                    (error) => showSnackBarError(context, message: error.getMessage(context)),
                    (imageBytes) =>
                        AutoRouter.of(context).push(GalleryPhotoTakenRoute(imageBytes: imageBytes)),
                  );
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // TODO: Delete picture
                },
                child: Text(
                  context.l10n.edit_photo_delete_photo_action,
                  style: LoonoFonts.fontStyle,
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
