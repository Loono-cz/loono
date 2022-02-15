import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
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
  final PageRouteInfo? closeRoute;
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
                const Spacer(),
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
                              if (status == CropStatus.ready) {
                                setState(() {
                                  isLoading = false;
                                  isCropping = false;
                                });
                              }
                              if (status == CropStatus.cropping) {
                                setState(() {
                                  isLoading = true;
                                  isCropping = true;
                                });
                              }
                            },
                            onCropped: (imageBytes) => AutoRouter.of(context)
                                .push(PhotoCroppedResultRoute(imageBytes: imageBytes)),
                          ),
                  ),
                ),
                const Spacer(),
                LoonoButton(
                  enabled: isLoading == false && isCropping == false,
                  text: context.l10n.continue_info,
                  onTap: cropController.crop,
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: widget.onSecondaryButtonTap,
                  child: Text(widget.secondaryButtonText, style: LoonoFonts.fontStyle),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
