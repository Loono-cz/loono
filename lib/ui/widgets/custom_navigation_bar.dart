import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/ui/widgets/notification_icon.dart';

// ignore: constant_identifier_names
const BOTTOM_NAV_BAR_HEIGHT = 90.0;

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    Key? key,
    required this.onTap,
    required this.currentIndex,
    required this.items,
  }) : super(key: key);

  final Function(int) onTap;
  final int currentIndex;
  final List<CustomNavigationBarItem> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: BOTTOM_NAV_BAR_HEIGHT,
      width: double.infinity,
      child: Material(
        color: LoonoColors.settingsBackground,
        child: Row(
          children: items
              .mapIndexed(
                (index, item) => Expanded(
                  child: InkWell(
                    onTap: () => onTap(index),
                    splashColor: LoonoColors.beigeLight,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: index == currentIndex
                                ? LoonoColors.primaryEnabled
                                : Colors.transparent,
                            width: 3.0,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 24,
                            child: SvgPicture.asset(
                              index == currentIndex ? item.iconPathActive : item.iconPath,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (item.hasNotification) ...[
                                const NotificationIcon.priority(width: 10),
                                const SizedBox(width: 4),
                              ],
                              Text(
                                item.label,
                                style: TextStyle(
                                  color: LoonoColors.primaryEnabled,
                                  fontSize: 10,
                                  fontWeight:
                                      index == currentIndex ? FontWeight.w700 : FontWeight.w400,
                                ),
                              ),
                              if (item.hasNotification) const SizedBox(width: 14),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class CustomNavigationBarItem {
  const CustomNavigationBarItem({
    required this.label,
    required this.iconPath,
    required this.iconPathActive,
    this.hasNotification = false,
  });

  final String label;
  final String iconPath;
  final String iconPathActive;
  final bool hasNotification;
}
