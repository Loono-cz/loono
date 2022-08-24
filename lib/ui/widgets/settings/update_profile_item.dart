import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UpdateProfileItem extends StatefulWidget {
  const UpdateProfileItem({
    Key? key,
    required this.label,
    required this.value,
    required this.route,
    this.enabled = true,
    this.messageTitle,
    this.messageText,
  }) : super(key: key);

  final String label;
  final String value;
  final PageRouteInfo? route;
  final String? messageTitle;
  final String? messageText;

  /// If `false` then [BottomSheet] will be shown on tap.
  final bool enabled;

  @override
  State<UpdateProfileItem> createState() => _UpdateProfileItemState();
}

class _UpdateProfileItemState extends State<UpdateProfileItem> with TickerProviderStateMixin {
  AnimationController? _popUpAnimController;
  PersistentBottomSheetController? sheetController;
  TextEditingController textController = TextEditingController();
  void showPopup() {
    _popUpAnimController =
        AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    final screenHeight = MediaQuery.of(context).size.height;
    showDialog<void>(
      context: context,
      barrierColor: Colors.black38,
      useSafeArea: false,
      builder: (_) => PopUp(
        controller: _popUpAnimController!,
        label: widget.label,
        screenHeight: screenHeight,
        messageText: widget.messageText,
        messageTitle: widget.messageTitle,
      ),
    );
  }

  @override
  void dispose() {
    if (_popUpAnimController != null) {
      _popUpAnimController!.dispose();
      _popUpAnimController = null;
    }
    super.dispose();
  }

  @override
  void initState() {
    textController.text = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final disabledColor = widget.enabled ? Colors.black : Colors.black26;

    final textFieldBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: disabledColor),
    );

    return TextField(
      style: TextStyle(color: widget.enabled ? Colors.black : Colors.black26),
      controller: textController,
      readOnly: true,
      onTap: () => widget.enabled
          ? (widget.route == null ? null : AutoRouter.of(context).push(widget.route!))
          : showPopup(),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        floatingLabelStyle: TextStyle(color: disabledColor),
        focusedBorder: textFieldBorder,
        border: textFieldBorder,
        enabledBorder: textFieldBorder,
        labelText: widget.label,
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }
}

class PopUp extends StatefulWidget {
  const PopUp({
    Key? key,
    required this.controller,
    required this.label,
    required this.screenHeight,
    this.messageTitle,
    this.messageText,
  }) : super(key: key);

  final AnimationController controller;
  final String label;
  final double screenHeight;
  final String? messageTitle;
  final String? messageText;

  @override
  State<StatefulWidget> createState() => PopUpState();
}

class PopUpState extends State<PopUp> {
  late Animation<double> opacityAnimation;
  Tween<double> opacityTween = Tween<double>(begin: 0.0, end: 1.0);
  late Tween<double> marginTopTween =
      Tween<double>(begin: widget.screenHeight, end: widget.screenHeight - 300);
  late Animation<double> marginTopAnimation;
  late AnimationStatus animationStatus;
  double dragStart = 0;

  @override
  void initState() {
    super.initState();

    marginTopAnimation = marginTopTween.animate(widget.controller)
      ..addListener(() {
        animationStatus = widget.controller.status;

        if (animationStatus == AnimationStatus.dismissed) {
          AutoRouter.of(context).pop();
        }

        if (mounted) {
          setState(() {});
        }
      });
    widget.controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacityTween.animate(widget.controller),
      child: GestureDetector(
        onTap: () {
          widget.controller.reverse();
        },
        onVerticalDragStart: (drag) {
          setState(() {
            dragStart = drag.globalPosition.dy;
          });
          widget.controller.value = 1;
        },
        onVerticalDragUpdate: (drag) {
          widget.controller.value = (widget.screenHeight - 300) /
              ((widget.screenHeight - 300) - (dragStart - drag.globalPosition.dy));
        },
        onVerticalDragEnd: (drag) {
          setState(() {
            dragStart = 0;
          });
          if (drag.velocity.pixelsPerSecond.dy > 0) {
            widget.controller.reverse();
          } else {
            widget.controller.forward();
          }
        },
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: EdgeInsets.only(
              top: marginTopAnimation.value,
            ),
            decoration: BoxDecoration(
              color: LoonoColors.primary,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                      onPressed: () => widget.controller.reverse(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${widget.messageTitle}',
                                style: const TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          children: [
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(color: Colors.black, fontSize: 14),
                                  text: widget.messageText,
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
                                          if (await canLaunchUrlString(emailLaunchUri.toString())) {
                                            await launchUrlString(emailLaunchUri.toString());
                                          }
                                        },
                                    ),
                                    const TextSpan(
                                      text: '.',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
