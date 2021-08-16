import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
    this.paused = false,
    this.currentPage = 0,
  }) : super(key: key);

  final String source;
  final FileType type;
  final bool autoplay;
  final bool looping;
  final bool paused;
  final VoidCallback? onLoaded;
  final int currentPage;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<CustomVideoPlayer> {
  late final VideoPlayerController _controller;
  late final Future<void> _initializeVideoPlayerFuture;
  late final int initialPage;

  @override
  void initState() {
    super.initState();
    initialPage = widget.currentPage;
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
      if (widget.paused != oldWidget.paused) {
        oldWidget.paused ? _controller.play() : _controller.pause();
      }

      if ((initialPage != oldWidget.currentPage) ||
          (initialPage == oldWidget.currentPage && initialPage != widget.currentPage)) {
        if (initialPage <= oldWidget.currentPage && widget.paused) {
          if (!(initialPage > oldWidget.currentPage)) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              if (mounted) widget.onLoaded?.call();
            });
          }
          _controller
            ..seekTo(Duration.zero)
            ..play();
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
