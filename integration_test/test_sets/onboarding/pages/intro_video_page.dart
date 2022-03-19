import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/intro_video.dart';
import 'package:video_player/video_player.dart';

import '../../../test_helpers/widget_tester_extensions.dart';

class IntroVideoPage {
  IntroVideoPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder playAgainBtn = find.widgetWithText(LoonoButton, 'Přehrát znovu');
  final Finder continueBtn = find.widgetWithText(LoonoButton, 'Pokračovat');

  /// Page methods
  Future<void> waitForVideoLoad() async {
    await tester.pumpUntilNotVisible(find.byType(CircularProgressIndicator));
  }

  Future<void> clickContinueBtn() async {
    await tester.tap(continueBtn);
    await tester.pumpAndSettle();
  }

  void checkVideoIsMuted() {
    final introVideo = tester.widget<IntroVideo>(find.byType(IntroVideo));
    expect(introVideo.storyPageState.isMuted, true);
  }

  Future<void> replayVideo() async {
    final videoPlayer = tester.widget<VideoPlayer>(find.byType(VideoPlayer));
    await tester.pump(const Duration(seconds: 1));
    final beforeResetProgress = videoPlayer.controller.value;
    await clickPlayAgainBtn(pumpAndSettle: false);
    await tester.pump(const Duration(milliseconds: 100));
    final afterResetProgress = videoPlayer.controller.value;
    expect(afterResetProgress.position < beforeResetProgress.position, true);
    await tester.pump(const Duration(seconds: 2));
  }

  Future<void> clickPlayAgainBtn({bool pumpAndSettle = true}) async {
    await tester.tap(playAgainBtn);
    if (pumpAndSettle) await tester.pumpAndSettle();
  }
}
