import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/ui/widgets/extend_inkwell.dart';

/// TODO: Async loading button placeholder (https://cesko-digital.atlassian.net/browse/LOON-476)
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
  ///
  /// If the evaluation of the this async function returns `true`, [onSuccess]
  /// callback will be called. Else if it returns `false`, [onError] callback will be called.
  final Future<bool?> Function() asyncCallback;

  /// Callback is called if [asyncCallback] returns `true`.
  final VoidCallback? onSuccess;

  /// Callback is called if [asyncCallback] returns `false`.
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
      /// check if not loading to prevent spamming api
      onTap: widget.enabled && !_isLoading
          ? () async {
              setState(() => _isLoading = true);
              final asyncResult = await widget.asyncCallback();
              setState(() => _isLoading = false);
              if (asyncResult == true) {
                widget.onSuccess?.call();
              } else if (asyncResult == false) {
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

class AsyncLoonoApiButton extends StatefulWidget {
  const AsyncLoonoApiButton({
    Key? key,
    required this.text,
    required this.asyncCallback,
    this.enabled = true,
    this.textColor,
  }) : super(key: key);
  final Future<dynamic> Function() asyncCallback;

  final String text;
  final bool enabled;
  final Color? textColor;

  @override
  _AsyncLoonoApiButtonState createState() => _AsyncLoonoApiButtonState();
}

class _AsyncLoonoApiButtonState extends State<AsyncLoonoApiButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ExtendedInkWell(
      /// check if not loading to prevent spamming api
      onTap: widget.enabled && !_isLoading
          ? () async {
              setState(() => _isLoading = true);
              await widget.asyncCallback();
              setState(() => _isLoading = false);
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
