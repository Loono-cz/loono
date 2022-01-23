import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';

void showConfirmationDialog(
  BuildContext context, {
  required VoidCallback onConfirm,
  VoidCallback? onCancel,
  required String content,
  String? confirmationButtonLabel,
  String? cancelButtonLabel,
}) {
  final Widget? cancelButton = onCancel != null
      ? TextButton(
          onPressed: onCancel,
          child: Text(cancelButtonLabel ?? context.l10n.cancel),
        )
      : null;
  final Widget confirmButton = TextButton(
    onPressed: onConfirm,
    child: Text(confirmationButtonLabel ?? context.l10n.continue_info),
  );

  showDialog<void>(
    context: context,
    useRootNavigator: false,
    builder: (context) => AlertDialog(
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
      actions: [
        cancelButton,
        confirmButton,
      ].whereType<Widget>().toList(),
    ),
  );
}
