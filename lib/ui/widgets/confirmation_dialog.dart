import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';

Future<void> showAdaptiveConfirmationDialog(
  BuildContext context, {
  required VoidCallback? onConfirm,
  VoidCallback? onCancel,
  required String description,
  required String confirmationButtonLabel,
  String? cancelButtonLabel,
}) async {
  final res = await showOkCancelAlertDialog(
    context: context,
    useRootNavigator: false,
    message: description,
    cancelLabel: cancelButtonLabel ?? context.l10n.cancel,
    okLabel: confirmationButtonLabel,
  );

  switch (res) {
    case OkCancelResult.ok:
      onConfirm?.call();
      break;
    case OkCancelResult.cancel:
      onCancel?.call();
      break;
  }
}
