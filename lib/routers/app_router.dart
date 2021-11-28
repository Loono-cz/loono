import 'dart:typed_data';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/screens/main/main_screen.dart';
import 'package:loono/ui/screens/settings/camera_photo_taken.dart';
import 'package:loono/ui/screens/settings/edit_email.dart';
import 'package:loono/ui/screens/settings/edit_nickname.dart';
import 'package:loono/ui/screens/settings/edit_photo.dart';
import 'package:loono/ui/screens/settings/gallery_photo_taken.dart';
import 'package:loono/ui/screens/settings/leaderboard.dart';
import 'package:loono/ui/screens/settings/open_settings.dart';
import 'package:loono/ui/screens/settings/photo_cropped_result.dart';
import 'package:loono/ui/screens/settings/points_help.dart';
import 'package:loono/ui/screens/settings/update_profile.dart';

part 'app_router.gr.dart';

const _openSettingsTransition = TransitionsBuilders.slideBottom;
const _settingsTransition = TransitionsBuilders.slideLeft;

// After editing this, run:
// flutter pub run build_runner build --delete-conflicting-outputs
//
// Post-auth screens
@MaterialAutoRouter(
  replaceInRouteName: 'Page|Screen|Dialog,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: EmptyRouterScreen,
      path: 'main-screen',
      name: 'MainScreenRouter',
      children: [
        AutoRoute(page: MainScreen, path: ''),

        // Settings
        CustomRoute(
          page: EmptyRouterScreen,
          path: 'settings',
          name: 'SettingsRouter',
          transitionsBuilder: _openSettingsTransition,
          children: [
            AutoRoute(page: OpenSettingsScreen, path: ''),
            CustomRoute(
              page: UpdateProfileScreen,
              path: 'update-profile',
              transitionsBuilder: _settingsTransition,
            ),
            CustomRoute(
              page: EditNicknameScreen,
              path: 'update-profile/nickname',
              transitionsBuilder: _settingsTransition,
            ),
            CustomRoute(
              page: EditEmailScreen,
              path: 'update-profile/email',
              transitionsBuilder: _settingsTransition,
            ),
            CustomRoute(
              page: EditPhotoScreen,
              path: 'settings/update-profile/photo',
              transitionsBuilder: _settingsTransition,
            ),
            CustomRoute(
              page: CameraPhotoTakenScreen,
              path: 'settings/update-profile/photo/camera-taken',
              transitionsBuilder: _settingsTransition,
            ),
            CustomRoute(
              page: GalleryPhotoTakenScreen,
              path: 'settings/update-profile/photo/gallery-taken',
              transitionsBuilder: _settingsTransition,
            ),
            CustomRoute(
              page: PhotoCroppedResultScreen,
              path: 'settings/update-profile/photo/photo-cropped-result',
              transitionsBuilder: _settingsTransition,
            ),
            CustomRoute(
              page: LeaderboardScreen,
              path: 'leaderboard',
              transitionsBuilder: _settingsTransition,
            ),
            CustomRoute(
              page: PointsHelpScreen,
              path: 'points-help',
              transitionsBuilder: _settingsTransition,
            ),
          ],
        ),
      ],
    ),
  ],
)
class AppRouter extends _$AppRouter {}
