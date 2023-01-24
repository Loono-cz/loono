import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/custom_navigation_bar.dart';
import 'package:loono/utils/registry.dart';

Widget bottomNavigationBuilder(
  BuildContext context,
  TabsRouter tabsRouter,
  List<String> analyticsTabNames, {
  bool hasNotification = false,
}) {
  return CustomNavigationBar(
    onTap: (index) async {
      await registry
          .get<FirebaseAnalytics>()
          .setCurrentScreen(screenName: analyticsTabNames[index]);
      tabsRouter.setActiveIndex(index);
    },
    currentIndex: tabsRouter.activeIndex,
    items: [
      CustomNavigationBarItem(
        hasNotification: hasNotification,
        label: context.l10n.main_menu_item_prevention,
        iconPath: 'assets/icons/tabs/prevention.svg',
        iconPathActive: 'assets/icons/tabs/prevention_active.svg',
      ),
      CustomNavigationBarItem(
        label: context.l10n.main_menu_item_find_doc,
        iconPath: 'assets/icons/tabs/find_doctor.svg',
        iconPathActive: 'assets/icons/tabs/find_doctor_active.svg',
      ),
      CustomNavigationBarItem(
        label: context.l10n.main_menu_item_about_health,
        iconPath: 'assets/icons/tabs/explore.svg',
        iconPathActive: 'assets/icons/tabs/explore_active.svg',
      ),
    ],
  );
}
