import 'package:flutter/material.dart';

const _defaultDuration = Duration(seconds: 15);

enum StoryPageBackground { dark, light }

enum PlayState { playing, paused, reset }

class StoryPageState {
  StoryPageState({
    this.playState = PlayState.paused,
    this.muteState = true,
    this.pageIndexState = 0,
  });

  PlayState playState;
  bool muteState;
  final int pageIndexState;

  bool get isPaused => playState == PlayState.paused;

  bool get isPlaying => playState == PlayState.playing;

  bool get isInResetState => playState == PlayState.reset;

  bool get isMuted => muteState == true;

  void reset() => playState = PlayState.reset;

  void pause() => playState = PlayState.paused;

  void unpause() => playState = PlayState.playing;

  void mute() => muteState = true;

  void unmute() => muteState = false;

  StoryPageState copyWith({
    PlayState? playState,
    bool? muteState,
    int? pageIndexState,
  }) {
    return StoryPageState(
      playState: playState ?? this.playState,
      muteState: muteState ?? this.muteState,
      pageIndexState: pageIndexState ?? this.pageIndexState,
    );
  }
}

class StoryPage extends StatelessWidget {
  const StoryPage({
    Key? key,
    required this.content,
    this.duration = _defaultDuration,
    this.interactiveContent,
    this.storyPageBackground = StoryPageBackground.light,
    this.autoplay = true,
    this.indicatorVisible = false,
  }) : super(key: key);

  const StoryPage.dark({
    Key? key,
    required this.content,
    this.interactiveContent,
    this.duration = _defaultDuration,
    this.autoplay = true,
    this.indicatorVisible = false,
  })  : storyPageBackground = StoryPageBackground.dark,
        super(key: key);

  final Widget content;
  final Widget? interactiveContent;
  final StoryPageBackground storyPageBackground;
  final Duration duration;
  final bool indicatorVisible;

  /// If `false` then the story will not start playing when shown. For example in videos, where the
  /// story indicator animation should wait till the video gets loaded.
  final bool autoplay;

  bool get hasInteractiveContent => interactiveContent != null;

  @override
  Widget build(BuildContext context) => content;
}
