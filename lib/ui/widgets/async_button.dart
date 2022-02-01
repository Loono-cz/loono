import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/ui/widgets/extend_inkwell.dart';

class AsyncLoonoButton extends StatefulWidget {
  const AsyncLoonoButton({
    Key? key,
    required this.text,
    required this.asyncCallback,
    required this.onSuccess,
    required this.onError,
    this.enabled = true,
    this.textColor,
  }) : super(key: key);

  /// Called only if [enabled] is `true`.
  final Future<bool> Function() asyncCallback;
  final VoidCallback? onSuccess;
  final VoidCallback? onError;
  final String text;
  final bool enabled;
  final Color? textColor;

  @override
  State<AsyncLoonoButton> createState() => _AsyncLoonoButtonState();
}

class _AsyncLoonoButtonState extends State<AsyncLoonoButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ExtendedInkWell(
      onTap: widget.enabled
          ? () async {
              setState(() => _isLoading = true);
              final asyncResult = await widget.asyncCallback();
              setState(() => _isLoading = false);
              if (asyncResult == true) {
                widget.onSuccess?.call();
              } else {
                widget.onError?.call();
              }
            }
          : null,
      splashColor: widget.enabled ? null : Colors.transparent,
      materialColor: widget.enabled ? LoonoColors.primaryEnabled : LoonoColors.primaryDisabled,
      borderRadius: BorderRadius.circular(10.0),
      child: SizedBox(
        height: 65.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: _isLoading,
              child: const Flexible(child: CircularProgressIndicator(color: Colors.white)),
            ),
            Expanded(
              child: Align(
                child: Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.button?.copyWith(
                        color: widget.textColor ?? Colors.white,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
