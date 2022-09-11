import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/ui/screens/settings/edit_photo.dart';
import 'package:loono/ui/screens/settings/leaderboard.dart';
import 'package:loono/ui/screens/settings/open_settings.dart';
import 'package:loono/ui/screens/settings/points_help.dart';
import 'package:loono/ui/screens/settings/update_profile.dart';
import 'package:loono/ui/widgets/close_button.dart';
import 'package:loono/utils/registry.dart';

//ignore_for_file: constant_identifier_names
// Settings Page names in Upper case for analytics tracking
enum SettingsPage {
  SettingsMainPage,
  SettingsEditPage,
  SettingsPhotoPage,
  SettingsPhotoCropPage,
  SettingsPhotoResultPage,
  SettingsPointsPage,
  SettingsLeaderboardPage,
}

void showSettingsSheet(BuildContext context, {SettingsPage? settingsPage, bool? expand}) {
  registry.get<FirebaseAnalytics>().logEvent(name: 'SettingsMainPage');
  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    isScrollControlled: true,
    builder: (context) {
      return _SettingsContent(
        settingsPage: settingsPage,
        expand: expand,
      );
    },
  ).whenComplete(() {
    registry.get<FirebaseAnalytics>().logEvent(name: 'CloseSettings');
  });
}

class _SettingsContent extends StatefulWidget {
  _SettingsContent({Key? key, this.settingsPage, this.expand}) : super(key: key);

  final SettingsPage? settingsPage;
  bool? expand;
  @override
  _SettingsContentState createState() => _SettingsContentState();
}

class _SettingsContentState extends State<_SettingsContent> {
  /// Custom navigation stack. Because, what could possibly go wrong... :D
  List<SettingsPage> navigationStack = [SettingsPage.SettingsMainPage];
  SettingsPage prevPage = SettingsPage.SettingsMainPage;
  Uint8List? imageBytes;
  bool? expand;

  void changePage(SettingsPage newPage) {
    setState(() {
      navigationStack.add(newPage);
    });
    registry.get<FirebaseAnalytics>().logEvent(name: newPage.name);
  }

  void goBack() {
    if (navigationStack.length > 1) {
      setState(() {
        navigationStack.removeLast();
      });
      registry.get<FirebaseAnalytics>().logEvent(name: navigationStack.last.name);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.settingsPage != null) navigationStack.add(widget.settingsPage!);
    setState(() {
      expand = widget.expand ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (navigationStack.length > 1) {
          goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          color: LoonoColors.beigeLighter,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 18),
              Row(
                children: [
                  if (navigationStack.lastOrNull != SettingsPage.SettingsMainPage)
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(32)),
                      child: Material(
                        color: Colors.transparent,
                        child: IconButton(
                          key: const Key('settings_sheet_backButton'),
                          onPressed: goBack,
                          icon: SvgPicture.asset(
                            'assets/icons/arrow_back.svg',
                          ),
                        ),
                      ),
                    ),
                  const Spacer(),
                  LoonoCloseButton(
                    key: const Key('settings_sheet_closeButton'),
                    onPressed: () => AutoRouter.of(context).popForced(),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              showPropperSettings(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget showPropperSettings(BuildContext context) {
    switch (navigationStack.last) {
      case SettingsPage.SettingsMainPage:
        return OpenSettingsScreen(
          changePage: changePage,
        );

      case SettingsPage.SettingsEditPage:
        return UpdateProfileScreen(
          changePage: changePage,
          expandNotSection: expand,
        );

      case SettingsPage.SettingsPointsPage:
        return PointsHelpScreen(
          changePage: changePage,
        );
      case SettingsPage.SettingsLeaderboardPage:
        return LeaderboardScreen(
          changePage: changePage,
        );
      default:
        return EditPhotoScreen(
          changePage: changePage,
        );
    }
  }
}
