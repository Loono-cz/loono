// ignore_for_file: constant_identifier_names
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/utils/permission_utils.dart';
import 'package:loono/utils/registry.dart';
import 'package:permission_handler/permission_handler.dart';

part 'image_utils.freezed.dart';

enum RequiredImagePermission { camera, storage }

/// 10 MB
const int _MAX_IMAGE_SIZE_IN_BYTES = 10000000;

extension RequiredImagePermissionExt on RequiredImagePermission {
  String getPermissionName(BuildContext context) {
    switch (this) {
      case RequiredImagePermission.camera:
        return context.l10n.permission_camera;
      case RequiredImagePermission.storage:
        return context.l10n.permission_storage;
    }
  }
}

/// Checks if the [imageBytes] size is bigger than the max limit ([_MAX_IMAGE_SIZE_IN_BYTES]).
bool isImageBiggerThanLimit(Uint8List imageBytes) =>
    imageBytes.lengthInBytes > _MAX_IMAGE_SIZE_IN_BYTES;

Future<Either<ImageError, Uint8List>> takePictureAsBytes(ImageSource imageSource) async {
  Permission permission;
  RequiredImagePermission requiredImagePermission;
  switch (imageSource) {
    case ImageSource.camera:
      permission = Permission.camera;
      requiredImagePermission = RequiredImagePermission.camera;
      break;
    case ImageSource.gallery:
      permission = Permission.storage;
      requiredImagePermission = RequiredImagePermission.storage;
      break;
  }

  final permissionResult = await getPermissionStatus(permission);
  switch (permissionResult) {
    case PermissionStatus.denied:
      return Left(ImageError.permissionDenied(requiredImagePermission));
    case PermissionStatus.permanentlyDenied:
    case PermissionStatus.restricted:
    case PermissionStatus.limited:
      return Left(ImageError.permissionPermanentlyDenied(requiredImagePermission));
    case PermissionStatus.granted:
      // Permission is granted, pick an image
      final XFile? picture;
      try {
        picture = await registry
            .get<ImagePicker>()
            .pickImage(source: imageSource, preferredCameraDevice: CameraDevice.front);
      } catch (e) {
        // TODO: Better error messaging
        return const Left(ImageError.unknown());
      }
      return picture == null
          ? const Left(ImageError.noMessage())
          : Right(await picture.readAsBytes());
  }
}

extension ImageErrorMessagesExt on ImageError {
  String getMessage(BuildContext context) {
    return when(
      noMessage: () => '',
      unknown: () => context.l10n.image_error_unknown,
      permissionDenied: (permission) =>
          '${context.l10n.image_error_permission_denied} ${permission.getPermissionName(context)}.',
      permissionPermanentlyDenied: (permission) {
        switch (permission) {
          case RequiredImagePermission.camera:
            return '${context.l10n.image_error_permission_permanently_denied_camera} ${context.l10n.image_error_permission_settings_info}';
          case RequiredImagePermission.storage:
            return '${context.l10n.image_error_permission_permanently_denied_storage} ${context.l10n.image_error_permission_settings_info}';
        }
      },
      network: () => context.l10n.image_error_network,
      sizeExceeded: () => context.l10n.image_error_size_exceeded,
    );
  }
}

@freezed
class ImageError with _$ImageError {
  const ImageError._();

  const factory ImageError.unknown() = UnknownError;

  const factory ImageError.noMessage() = NoMessageError;

  const factory ImageError.permissionDenied(RequiredImagePermission permission) = PermissionDenied;

  const factory ImageError.permissionPermanentlyDenied(RequiredImagePermission permission) =
      PermissionPermanentlyDenied;

  const factory ImageError.network() = NetworkError;

  const factory ImageError.sizeExceeded() = SizeExceededError;
}
