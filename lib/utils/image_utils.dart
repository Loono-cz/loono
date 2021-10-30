import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/utils/registry.dart';
import 'package:permission_handler/permission_handler.dart';

part 'image_utils.freezed.dart';

enum RequiredImagePermission { camera, storage }

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

  final permissionResult = await _checkHasPermission(permission);
  switch (permissionResult) {
    case PermissionStatus.denied:
      return Left(ImageError.permissionDenied(requiredImagePermission));
    case PermissionStatus.permanentlyDenied:
      return Left(ImageError.permissionPermanentlyDenied(requiredImagePermission));
    case PermissionStatus.restricted:
    case PermissionStatus.limited:
      return Left(ImageError.permissionLimited(requiredImagePermission));
    case PermissionStatus.granted:
      // Permission is granted, pick an image
      final XFile? picture;
      try {
        picture = await registry.get<ImagePicker>().pickImage(source: imageSource);
      } catch (e) {
        // TODO: Better error messaging
        return const Left(ImageError.unknown());
      }
      return picture == null
          ? const Left(ImageError.noMessage())
          : Right(await picture.readAsBytes());
  }
}

Future<PermissionStatus> _checkHasPermission(Permission permission) async {
  final PermissionStatus status = await permission.status;
  switch (status) {
    case PermissionStatus.granted:
      return PermissionStatus.granted;
    case PermissionStatus.denied:
      // We didn't ask for permission yet or the permission has been denied before but not permanently
      if (await permission.request().isGranted) {
        // Either the permission was already granted before or the user just granted it
        return PermissionStatus.granted;
      }
      return PermissionStatus.denied;
    case PermissionStatus.permanentlyDenied:
      return PermissionStatus.permanentlyDenied;
    case PermissionStatus.restricted:
    case PermissionStatus.limited:
      // The OS restricts access, for example because of parental controls (only supported on iOS)
      return PermissionStatus.limited;
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
      permissionLimited: (permission) {
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

  const factory ImageError.permissionLimited(RequiredImagePermission permission) =
      PermissionLimited;

  const factory ImageError.network() = NetworkError;

  const factory ImageError.sizeExceeded() = SizeExceededError;
}
