import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/firebase_storage_service.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/settings/app_bar.dart';
import 'package:loono/ui/widgets/settings/avatar.dart';
import 'package:loono/utils/image_utils.dart';
import 'package:loono/utils/registry.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PhotoCroppedResultScreen extends StatefulWidget {
  const PhotoCroppedResultScreen({Key? key, required this.imageBytes}) : super(key: key);

  final Uint8List imageBytes;

  @override
  State<PhotoCroppedResultScreen> createState() => _PhotoCroppedResultScreenState();
}

class _PhotoCroppedResultScreenState extends State<PhotoCroppedResultScreen> {
  bool _isUploading = false;
  bool _uploadCancelled = false;

  final _firebaseStorageService = registry.get<FirebaseStorageService>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_isUploading) {
          _uploadCancelled = true;
          await _firebaseStorageService.uploadTask?.cancel();
          return false;
        }
        return true;
      },
      child: ModalProgressHUD(
        inAsyncCall: _isUploading,
        progressIndicator: const CircularProgressIndicator(color: LoonoColors.primaryEnabled),
        opacity: 0.5,
        child: Scaffold(
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
                  CustomLoonoAvatar.memory(
                    radius: MediaQuery.of(context).size.width * 0.3,
                    imageBytes: widget.imageBytes,
                  ),
                  const Spacer(),
                  LoonoButton(
                    text: context.l10n.action_save,
                    onTap: () async {
                      if (isImageBiggerThanLimit(widget.imageBytes)) {
                        showSnackBarError(context, message: context.l10n.image_error_size_exceeded);
                        return;
                      }
                      setState(() => _isUploading = true);
                      final photoUploadResult =
                          await registry.get<UserRepository>().updateUserPhoto(widget.imageBytes);
                      setState(() => _isUploading = false);
                      if (photoUploadResult) {
                        AutoRouter.of(context).pushAndPopUntil(
                          EditPhotoRoute(imageBytes: widget.imageBytes),
                          predicate: (route) => route.settings.name == UpdateProfileRoute.name,
                        );
                        showFlushBarSuccess(context, context.l10n.photo_changed_success,
                            sync: false);
                      } else if (!_uploadCancelled) {
                        showSnackBarError(context,
                            message: const ImageError.unknown().getMessage(context));
                      }
                      _uploadCancelled = false;
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
        ),
      ),
    );
  }
}
