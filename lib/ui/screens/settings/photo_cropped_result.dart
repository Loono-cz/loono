import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/routers/app_router.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/settings/app_bar.dart';
import 'package:loono/ui/widgets/settings/avatar.dart';

class PhotoCroppedResultScreen extends StatelessWidget {
  const PhotoCroppedResultScreen({Key? key, required this.imageBytes}) : super(key: key);

  final Uint8List imageBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: settingsAppBar(context, closeRoute: EditPhotoRoute()),
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
              const SizedBox(height: 31),
              LoonoAvatar(radius: MediaQuery.of(context).size.width * 0.3, imageBytes: imageBytes),
              const Spacer(),
              LoonoButton(
                text: context.l10n.action_save,
                onTap: () {
                  // TODO: Save picture to Firebase
                  showSnackBarSuccess(context, message: context.l10n.photo_changed_success);
                  AutoRouter.of(context).pushAndPopUntil(
                    EditPhotoRoute(imageBytes: imageBytes),
                    predicate: (route) => route.settings.name == UpdateProfileRoute.name,
                  );
                },
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () => AutoRouter.of(context).pop(),
                child: Text(context.l10n.photo_crop_again_action, style: LoonoFonts.fontStyle),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
