import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';

/// Pre-auth main screen.
class PreAuthMainScreen extends StatelessWidget {
  const PreAuthMainScreen({
    Key? key,
    this.overridenPreventionRoute,
  }) : super(key: key);

  final PageRouteInfo? overridenPreventionRoute;

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        PreAuthPreventionWrapperRoute(forceRoute: overridenPreventionRoute),
        FindDoctorRoute(),
        const AboutHealthRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        // TODO: unify widgets with Post-auth MainScreen
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          selectedItemColor: LoonoColors.primaryEnabled,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: context.l10n.main_menu_item_prevention,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: context.l10n.main_menu_item_find_doc,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.lightbulb_outline),
              label: context.l10n.main_menu_item_about_health,
            ),
          ],
        );
      },
    );
  }
}
