import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

enum FileType {
  URL, ASSETS
}

class CustomVideoPlayer extends StatefulWidget {
  final String source;
  final FileType type;
  final bool autoplay;
  CustomVideoPlayer({required this.type, required this.source, this.autoplay=true, Key? key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = (this.widget.type == FileType.URL) ?
      VideoPlayerController.network(this.widget.source) :
      VideoPlayerController.asset(this.widget.source);
    _initializeVideoPlayerFuture = _controller.initialize();
    _initializeVideoPlayerFuture.then((val) => {
      if (this.widget.autoplay)  _controller.play()
    });
    _controller.setLooping(true);
    super.initState();
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
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              child: FittedBox(
                  alignment: Alignment.center,
                  fit: BoxFit.fitWidth,
                  child: Container(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller))),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
