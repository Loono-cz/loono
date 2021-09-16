import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:loono/ui/widgets/onboarding/carousel/story_page.dart';
import 'package:video_player/video_player.dart';

enum FileType { url, assets }

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({
    Key? key,
    required this.type,
    required this.source,
    this.autoplay = true,
    this.looping = false,
    this.onLoaded,
    required this.storyPageState,
  }) : super(key: key);

  final String source;
  final FileType type;
  final bool autoplay;
  final bool looping;
  final VoidCallback? onLoaded;
  final StoryPageState storyPageState;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<CustomVideoPlayer> {
  late final VideoPlayerController _controller;
  late final Future<void> _initializeVideoPlayerFuture;
  late final int initialPage;

  void resetVideo() {
    _controller
      ..seekTo(Duration.zero)
      ..play();
  }

  @override
  void initState() {
    super.initState();
    initialPage = widget.storyPageState.pageIndexState;
    _controller = (widget.type == FileType.url)
        ? VideoPlayerController.network(widget.source)
        : VideoPlayerController.asset(widget.source);
    _initializeVideoPlayerFuture = _controller.initialize();
    _initializeVideoPlayerFuture.then((_) {
      if (widget.autoplay) {
        _controller.play();
        widget.onLoaded?.call();
      }
    });
    _controller.setLooping(widget.looping);
  }

  @override
  void didUpdateWidget(CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_controller.value.isInitialized) {
      if (widget.storyPageState.hasResetState != oldWidget.storyPageState.hasResetState) {
        resetVideo();
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          if (mounted) widget.onLoaded?.call();
        });
      }

      if (widget.storyPageState.isPaused != oldWidget.storyPageState.isPaused) {
        oldWidget.storyPageState.isPaused ? _controller.play() : _controller.pause();
      }

      if (widget.storyPageState.isMuted != oldWidget.storyPageState.isMuted) {
        oldWidget.storyPageState.isMuted ? _controller.setVolume(1.0) : _controller.setVolume(0.0);
      }

      if ((initialPage != oldWidget.storyPageState.pageIndexState) ||
          (initialPage == oldWidget.storyPageState.pageIndexState &&
              initialPage != widget.storyPageState.pageIndexState)) {
        if (initialPage <= oldWidget.storyPageState.pageIndexState &&
            widget.storyPageState.isPaused) {
          if (!(initialPage > oldWidget.storyPageState.pageIndexState)) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              if (mounted) widget.onLoaded?.call();
            });
          }
          resetVideo();
        }
      }
    }
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
