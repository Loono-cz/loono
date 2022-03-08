import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/custom_navigation_bar.dart';

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

        return CustomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            CustomNavigationBarItem(
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
      },
    );
  }
}
