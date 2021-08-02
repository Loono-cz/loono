import 'package:flutter/material.dart';
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
  }) : super(key: key);

  final String source;
  final FileType type;
  final bool autoplay;
  final bool looping;
  final bool paused;
  final VoidCallback? onLoaded;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<CustomVideoPlayer> {
  late final VideoPlayerController _controller;
  late final Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
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
    super.initState();
  }

  @override
  void didUpdateWidget(CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_controller.value.isInitialized) {
      if (widget.paused != oldWidget.paused) {
        oldWidget.paused ? _controller.play() : _controller.pause();
        return;
      }

      if (_controller.value.position != Duration.zero) {
        // without this, quick swiping right and back will reset and stop the indicator, but the video will be still playing
        // (and without addPostFrameCallback it throws some errors)
        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          // without this delay, swiping right will replay the sound from the beginning of the video on the next screen for a moment
          await Future.delayed(const Duration(milliseconds: 750));
          if (mounted) {
            _controller.seekTo(Duration.zero);
            widget.onLoaded?.call();
          }
        });
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       _controller.value.isPlaying ? _controller.pause() : _controller.play();
      //     });
      //   },
      //   child: Icon(
      //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ),
    );
  }
}
