import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';

class LoonBottomSheet extends StatelessWidget {
  const LoonBottomSheet({
    Key? key,
    required this.child,
    this.sheetHeight = 340,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.topSpace = 10,
    this.bottomSpace = 60,
  }) : super(key: key);

  final Widget child;
  final double sheetHeight;
  final MainAxisAlignment mainAxisAlignment;
  final double topSpace;
  final double bottomSpace;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sheetHeight,
      decoration: const BoxDecoration(
        color: LoonoColors.bottomSheetPrevention,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => AutoRouter.of(context).pop(),
                ),
              ),
              SizedBox(
                height: topSpace,
              ),
              child,
              SizedBox(
                height: bottomSpace,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
