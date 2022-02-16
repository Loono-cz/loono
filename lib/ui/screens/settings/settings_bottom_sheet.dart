import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/ui/screens/settings/edit_photo.dart';
import 'package:loono/ui/screens/settings/leaderboard.dart';
import 'package:loono/ui/screens/settings/open_settings.dart';
import 'package:loono/ui/screens/settings/points_help.dart';
import 'package:loono/ui/screens/settings/update_profile.dart';

enum SettingsPage {
  main,
  edit,
  photo,
  photoCrop,
  photoResult,
  points,
  leaderboard,
}

void showSettingsSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    isScrollControlled: true,
    builder: (context) {
      return const _SettingsContent();
    },
  );
}

class _SettingsContent extends StatefulWidget {
  const _SettingsContent({Key? key}) : super(key: key);

  @override
  _SettingsContentState createState() => _SettingsContentState();
}

class _SettingsContentState extends State<_SettingsContent> {
  /// Custom navigation stack. Because, what could possibly go wrong... :D
  List<SettingsPage> navigationStack = [SettingsPage.main];
  SettingsPage prevPage = SettingsPage.main;
  Uint8List? imageBytes;

  void changePage(SettingsPage newPage) {
    setState(() {
      navigationStack.add(newPage);
    });
  }

  void goBack() {
    if (navigationStack.length > 1) {
      setState(() {
        navigationStack.removeLast();
      });
    }
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
                  if (navigationStack.lastOrNull != SettingsPage.main)
                    IconButton(
                      onPressed: goBack,
                      icon: SvgPicture.asset(
                        'assets/icons/arrow_back.svg',
                      ),
                    ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, size: 32),
                    onPressed: () {
                      AutoRouter.of(context).popForced();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 18),

              /// TODO: This works but might get refactor in the future
              if (navigationStack.last == SettingsPage.main)
                OpenSettingsScreen(
                  changePage: changePage,
                ),
              if (navigationStack.last == SettingsPage.edit)
                UpdateProfileScreen(
                  changePage: changePage,
                ),
              if (navigationStack.last == SettingsPage.points)
                PointsHelpScreen(
                  changePage: changePage,
                ),
              if (navigationStack.last == SettingsPage.leaderboard)
                LeaderboardScreen(
                  changePage: changePage,
                ),
              if (navigationStack.last == SettingsPage.photo)
                EditPhotoScreen(
                  changePage: changePage,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
