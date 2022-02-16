import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/screens/settings/settings_bottom_sheet.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/settings/avatar.dart';
import 'package:loono/utils/image_utils.dart';
import 'package:loono/utils/registry.dart';

class EditPhotoScreen extends StatelessWidget {
  const EditPhotoScreen({
    Key? key,
    this.imageBytes,
    required this.changePage,
  }) : super(key: key);

  final Function(SettingsPage) changePage;

  final Uint8List? imageBytes;

  double _getAvatarSize(BuildContext context) => MediaQuery.of(context).size.width * 0.3;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(context.l10n.photo_header, style: const TextStyle(fontSize: 24)),
            ),
            const Spacer(),
            if (imageBytes == null)
              LoonoAvatar(radius: _getAvatarSize(context))
            else
              CustomLoonoAvatar.memory(
                radius: _getAvatarSize(context),
                imageBytes: imageBytes,
              ),
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
              onPressed: () async {
                final result = await registry.get<UserRepository>().deleteUserPhoto();
                if (result) {
                  showSnackBarSuccess(
                    context,
                    message: context.l10n.edit_photo_delete_photo_action_success,
                  );
                }
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
    );
  }
}
