import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/webview_service.dart';
import 'package:loono/ui/widgets/custom_navigation_bar.dart';
import 'package:loono/utils/registry.dart';
import 'package:provider/provider.dart';

/// Pre-auth main screen.
class PreAuthMainScreen extends StatelessWidget {
  const PreAuthMainScreen({
    Key? key,
    this.overridenPreventionRoute,
  }) : super(key: key);

  final PageRouteInfo? overridenPreventionRoute;
  static const analyticsTabNames = [
    'PreAuthPreventionTab',
    'PreAuthFindDoctorTab',
    'PreAuthExploreSectionTab'
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final webViewController = context.read<WebViewProvider>().webViewController;
        if (webViewController != null && await webViewController.canGoBack()) {
          await webViewController.goBack();
        }
        return false;
      },
      child: AutoTabsScaffold(
        routes: [
          PreAuthPreventionWrapperRoute(forceRoute: overridenPreventionRoute),
          FindDoctorRoute(),
          AboutHealthRoute(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          // TODO: unify widgets with Post-auth MainScreen

          return CustomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) async {
              await registry
                  .get<FirebaseAnalytics>()
                  .setCurrentScreen(screenName: analyticsTabNames[index]);
              tabsRouter.setActiveIndex(index);
            },
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
      ),
    );
  }
}
