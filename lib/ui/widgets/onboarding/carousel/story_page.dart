import 'package:flutter/material.dart';

const _defaultDuration = Duration(seconds: 15);

enum StoryPageBackground { dark, light }

class StoryPage extends StatelessWidget {
  const StoryPage({
    Key? key,
    required this.content,
    this.duration = _defaultDuration,
    this.interactiveContent,
    this.storyPageBackground = StoryPageBackground.light,
    this.autoplay = true,
  }) : super(key: key);

  const StoryPage.dark({
    Key? key,
    required this.content,
    this.interactiveContent,
    this.duration = _defaultDuration,
    this.autoplay = true,
  })  : storyPageBackground = StoryPageBackground.dark,
        super(key: key);

  final Widget content;
  final Widget? interactiveContent;
  final StoryPageBackground storyPageBackground;
  final Duration duration;

  /// If `false` then the story will not start playing when shown. For example in videos, where the
  /// story indicator animation should wait till the video gets loaded.
  final bool autoplay;

  bool get hasInteractiveContent => interactiveContent != null;

  @override
  Widget build(BuildContext context) => content;
}
