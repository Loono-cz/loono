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
  final PageRouteInfo<dynamic>? route;

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
                : _showInfoSheet(),
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

  void _showInfoSheet() {
    const textStyle = TextStyle(color: LoonoColors.black, height: 1.5);

    _closeSheet();
    sheetController = Scaffold.of(context).showBottomSheet<dynamic>(
      (context) {
        return FractionallySizedBox(
          heightFactor: MediaQuery.of(context).size.height > 750 ? 0.32 : 0.39,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.close),
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
                            text:
                                '${widget.label} ${context.l10n.update_profile_can_not_edit_message} ',
                            style: textStyle,
                            children: [
                              TextSpan(
                                text: LoonoStrings.contactEmail,
                                style: textStyle.copyWith(decoration: TextDecoration.underline),
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
                              const TextSpan(text: '.', style: textStyle),
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

  void _closeSheet() {
    if (sheetController != null) {
      sheetController!.close();
      sheetController = null;
    }
  }
}
