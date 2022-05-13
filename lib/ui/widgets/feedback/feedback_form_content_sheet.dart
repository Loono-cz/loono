import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/ui/widgets/async_button.dart';
import 'package:loono/ui/widgets/close_button.dart';
import 'package:loono/utils/registry.dart';
import 'package:url_launcher/url_launcher.dart';

void showFeedbackFormContentBottomSheet(
  BuildContext pageContext, {
  required int rating,
}) {
  final borderRadius = BorderRadius.circular(10.0);
  showModalBottomSheet<void>(
    context: pageContext,
    useRootNavigator: true,
    shape: RoundedRectangleBorder(borderRadius: borderRadius),
    isScrollControlled: true,
    builder: (_) => _FeedbackFormContent(borderRadius: borderRadius, rating: rating),
  );
}

/// Stateful because hiding the keyboard action causes loosing the [TextField] text state
/// on small devices.
class _FeedbackFormContent extends StatefulWidget {
  const _FeedbackFormContent({
    Key? key,
    this.borderRadius,
    required this.rating,
  }) : super(key: key);

  final BorderRadius? borderRadius;
  final int rating;

  @override
  State<_FeedbackFormContent> createState() => _FeedbackFormContentState();
}

class _FeedbackFormContentState extends State<_FeedbackFormContent> {
  final _apiService = registry.get<ApiService>();

  final _authService = registry.get<AuthService>();

  final _textController = TextEditingController();

  Future<void> _closeForm(BuildContext context) async {
    await AutoRouter.of(context).pop();
    await AutoRouter.of(context).pop();
  }

  String get _inputText => _textController.text;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isScreenSmall = LoonoSizes.isScreenSmall(context);
    final l10n = context.l10n;
    const arrowBackWidth = 22.5;
    return Padding(
      padding: isScreenSmall ? EdgeInsets.zero : MediaQuery.of(context).viewInsets,
      child: FractionallySizedBox(
        heightFactor: 0.95,
        child: Container(
          decoration: BoxDecoration(
            color: LoonoColors.bottomSheetPrevention,
            borderRadius: widget.borderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: IconButton(
                        icon:
                            SvgPicture.asset('assets/icons/arrow_back.svg', width: arrowBackWidth),
                        onPressed: () => AutoRouter.of(context).pop(),
                      ),
                    ),
                    LoonoCloseButton(onPressed: () async => _closeForm(context)),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: arrowBackWidth / 2),
                  child: Text(
                    l10n.feedback_form_header,
                    style: LoonoFonts.headerFontStyle,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 8, right: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: _textController,
                        // Hides the keyboard on small devices on action done so the button gets visible.
                        // Does not send form to prevent accidental form sending.
                        onEditingComplete: () async =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        // Performs action done instead of new line on small devices.
                        textInputAction:
                            isScreenSmall ? TextInputAction.done : TextInputAction.newline,
                        maxLength: 500,
                        minLines: null,
                        maxLines: null,
                        expands: true,
                        autofocus: !isScreenSmall,
                        cursorColor: LoonoColors.black,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          counter: Text(
                            l10n.feedback_form_max_length.toUpperCase(),
                            style: LoonoFonts.cardSubtitle.copyWith(
                              color: LoonoColors.grey,
                            ),
                          ),
                          hintText: l10n.feedback_form_hint,
                          hintStyle: LoonoFonts.fontStyle.copyWith(color: LoonoColors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                AsyncLoonoButton(
                  text: l10n.feedback_form_send_button,
                  asyncCallback: () async => _apiService.sendFeedback(
                    uid: await _authService.userUid,
                    message: _inputText.isEmpty ? null : _inputText,
                    rating: widget.rating,
                  ),
                  onSuccess: () async {
                    await _closeForm(context);
                    showFlushBarSuccess(context, l10n.feedback_form_success_message, sync: false);
                  },
                  onError: () => showFlushBarError(context, l10n.something_went_wrong),
                ),
                const SizedBox(height: 20),
                Align(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Text.rich(
                      TextSpan(
                        text: l10n.feedback_form_support_text,
                        children: [
                          TextSpan(
                            text: LoonoStrings.contactEmail,
                            style:
                                LoonoFonts.fontStyle.copyWith(decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                final emailLaunchUri =
                                    Uri(scheme: 'mailto', path: LoonoStrings.contactEmail);
                                if (await canLaunch(emailLaunchUri.toString())) {
                                  await launch(emailLaunchUri.toString());
                                }
                              },
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                      style: LoonoFonts.fontStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
