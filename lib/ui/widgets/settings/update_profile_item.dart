import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateProfileItem extends StatefulWidget {
  const UpdateProfileItem({
    Key? key,
    required this.label,
    required this.value,
    required this.route,
    this.enabled = true,
  }) : super(key: key);

  final String label;
  final String value;
  final PageRouteInfo? route;

  /// If `false` then [BottomSheet] will be shown on tap.
  final bool enabled;

  @override
  State<UpdateProfileItem> createState() => _UpdateProfileItemState();
}

class _UpdateProfileItemState extends State<UpdateProfileItem> {
  PersistentBottomSheetController? sheetController;

  @override
  Widget build(BuildContext context) {
    const textFieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: Colors.transparent),
    );

    return Row(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 100, maxWidth: 100),
          child: Text(widget.label, style: const TextStyle(fontSize: 12, color: Colors.black)),
        ),
        Expanded(
          child: TextField(
            readOnly: true,
            onTap: () => widget.enabled
                ? (widget.route == null ? null : AutoRouter.of(context).push(widget.route!))
                : _showMaterialDialog(),
            decoration: InputDecoration(
              hintText: widget.value,
              hintStyle: const TextStyle(fontSize: 16, color: Colors.black),
              filled: true,
              fillColor: widget.enabled ? Colors.white : LoonoColors.pink,
              enabledBorder: textFieldBorder,
              disabledBorder: textFieldBorder,
              focusedBorder: textFieldBorder,
            ),
          ),
        ),
      ],
    );
  }

  void _showMaterialDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.only(
            left: 0,
            right: 0,
            bottom: 0,
            top: MediaQuery.of(context).size.height * 0.7,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: LoonoColors.primary,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 32,
                      ),
                      onPressed: () => AutoRouter.of(context).pop(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 35.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 22.0),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: Colors.black, fontSize: 14),
                            text:
                                '${widget.label} ${context.l10n.update_profile_can_not_edit_message} ',
                            children: [
                              TextSpan(
                                text: LoonoStrings.contactEmail,
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    final emailLaunchUri = Uri(
                                      scheme: 'mailto',
                                      path: LoonoStrings.contactEmail,
                                    );
                                    if (await canLaunch(emailLaunchUri.toString())) {
                                      await launch(emailLaunchUri.toString());
                                    }
                                  },
                              ),
                              const TextSpan(
                                text: '.',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
