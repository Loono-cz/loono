import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/settings/app_bar.dart';

class PhotoTakenContent extends StatefulWidget {
  const PhotoTakenContent({
    Key? key,
    required this.imageBytes,
    required this.secondaryButtonText,
    this.showBackButton = false,
    this.closeRoute,
    this.onSecondaryButtonTap,
  }) : super(key: key);

  final Uint8List imageBytes;
  final PageRouteInfo<dynamic>? closeRoute;
  final bool showBackButton;
  final VoidCallback? onSecondaryButtonTap;
  final String secondaryButtonText;

  @override
  State<PhotoTakenContent> createState() => _PhotoTakenContentState();
}

class _PhotoTakenContentState extends State<PhotoTakenContent> {
  final cropController = CropController();

  bool isLoading = true;
  bool isCropping = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: settingsAppBar(
          context,
          showBackButton: widget.showBackButton,
          closeRoute: widget.closeRoute ?? EditPhotoRoute(),
        ),
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
                Theme(
                  data: ThemeData(
                    progressIndicatorTheme: const ProgressIndicatorThemeData(
                      color: LoonoColors.primaryEnabled,
                    ),
                  ),
                  child: Flexible(
                    flex: 8,
                    child: isCropping
                        ? const Center(child: CircularProgressIndicator())
                        : Crop(
                            initialSize: 0.75,
                            baseColor: LoonoColors.settingsBackground,
                            maskColor: LoonoColors.settingsBackground.withAlpha(125),
                            image: widget.imageBytes,
                            withCircleUi: true,
                            controller: cropController,
                            onStatusChanged: (status) {
                              if (status == CropStatus.ready) setState(() => isLoading = false);
                              if (status == CropStatus.cropping) setState(() => isCropping = true);
                            },
                            onCropped: (imageBytes) {
                              // TODO: Save picture to Firebase
                              showSnackBarSuccess(context,
                                  message: context.l10n.photo_changed_success);
                              AutoRouter.of(context).pushAndPopUntil(
                                EditPhotoRoute(imageBytes: imageBytes),
                                predicate: (route) =>
                                    route.settings.name == UpdateProfileRoute.name,
                              );
                            },
                          ),
                  ),
                ),
                const Spacer(),
                LoonoButton(
                  enabled: isLoading == false && isCropping == false,
                  text: context.l10n.action_save,
                  onTap: () => cropController.crop(),
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: widget.onSecondaryButtonTap,
                  child: Text(widget.secondaryButtonText, style: LoonoFonts.fontStyle),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
