import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/screens/settings/settings_bottom_sheet.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/confirmation_dialog.dart';
import 'package:loono/ui/widgets/settings/avatar.dart';
import 'package:loono/utils/image_utils.dart';
import 'package:loono/utils/registry.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditPhotoScreen extends StatefulWidget {
  const EditPhotoScreen({
    Key? key,
    this.imageBytes,
    required this.changePage,
  }) : super(key: key);

  final Function(SettingsPage) changePage;

  final Uint8List? imageBytes;

  @override
  State<EditPhotoScreen> createState() => _EditPhotoScreenState();
}

class _EditPhotoScreenState extends State<EditPhotoScreen> {
  final _usersDao = registry.get<DatabaseService>().users;

  final _userRepository = registry.get<UserRepository>();

  double _getAvatarSize(BuildContext context) => MediaQuery.of(context).size.width * 0.3;

  bool _isLoading = false;

  void _setLoadingState(bool value) => setState(() => _isLoading = value);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ModalProgressHUD(
        inAsyncCall: _isLoading,
        progressIndicator: const CircularProgressIndicator(color: LoonoColors.primaryEnabled),
        opacity: 0.5,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(context.l10n.photo_header, style: const TextStyle(fontSize: 24)),
              ),
              const Spacer(),
              if (widget.imageBytes == null)
                LoonoAvatar(radius: _getAvatarSize(context))
              else
                CustomLoonoAvatar.memory(
                  radius: _getAvatarSize(context),
                  imageBytes: widget.imageBytes,
                ),
              const Spacer(flex: 2),
              LoonoButton.light(
                text: context.l10n.edit_photo_take_camera_picture_action,
                onTap: () async {
                  final result = await takePictureAsBytes(ImageSource.camera);
                  result.fold(
                    (error) => showFlushBarError(context, error.getMessage(context)),
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
                    (error) => showFlushBarError(context, error.getMessage(context)),
                    (imageBytes) =>
                        AutoRouter.of(context).push(GalleryPhotoTakenRoute(imageBytes: imageBytes)),
                  );
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () async {
                  final hasPhoto = _usersDao.user?.profileImageUrl != null;
                  if (!hasPhoto) return;
                  await showAdaptiveConfirmationDialog(
                    context,
                    description: context.l10n.photo_remove_confirmation_dialog_content,
                    confirmationButtonLabel: context.l10n.continue_info,
                    onConfirm: () async {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _setLoadingState(true);
                      });
                      final result = await _userRepository.deleteUserPhoto();
                      if (result) {
                        if (!mounted) return;
                        showFlushBarSuccess(
                          context,
                          context.l10n.edit_photo_delete_photo_action_success,
                        );
                      } else {
                        if (mounted) showFlushBarError(context, context.l10n.something_went_wrong);
                      }
                      if (mounted) _setLoadingState(false);
                    },
                  );
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
