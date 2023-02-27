import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/intro_video.dart';
import 'package:video_player/video_player.dart';

import '../../../test_helpers/e2e_action_logging.dart';
import '../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [IntroVideo]
class IntroVideoPage {
  IntroVideoPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder playAgainBtn = find.widgetWithText(LoonoButton, 'Přehrát znovu');
  final Finder continueBtn = find.widgetWithText(LoonoButton, 'Pokračovat');

  /// Page methods
  Future<void> waitForVideoLoad() async {
    logTestEvent();
    await tester.pumpUntilNotFound(find.byType(CircularProgressIndicator));
  }

  Future<void> clickContinueBtn() async {
    logTestEvent();
    await tester.tap(continueBtn);
    await tester.pumpAndSettle();
  }

  void checkVideoIsMuted() {
    logTestEvent();
    final introVideo = tester.widget<IntroVideo>(find.byType(IntroVideo));
    expect(introVideo.storyPageState.isMuted, true);
  }

  Future<void> replayVideo() async {
    logTestEvent();
    final videoPlayer = tester.widget<VideoPlayer>(find.byType(VideoPlayer));
    await tester.pump(const Duration(seconds: 1));
    final beforeResetProgress = videoPlayer.controller.value;
    await _clickPlayAgainBtn(pumpAndSettle: false);
    await tester.pump(const Duration(milliseconds: 10));
    final afterResetProgress = videoPlayer.controller.value;
    expect(afterResetProgress.position < beforeResetProgress.position, true);
    await tester.pump(const Duration(seconds: 2));
  }

  Future<void> _clickPlayAgainBtn({bool pumpAndSettle = true}) async {
    await tester.tap(playAgainBtn);
    if (pumpAndSettle) await tester.pumpAndSettle();
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(IntroVideo));
  }
}
