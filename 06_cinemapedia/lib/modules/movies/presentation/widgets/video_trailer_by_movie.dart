import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoTrailerByMovie extends StatefulWidget {
  final String movieId;

  const VideoTrailerByMovie({super.key, required this.movieId});

  @override
  State<VideoTrailerByMovie> createState() => _VideoTrailerByMovieState();
}

class _VideoTrailerByMovieState extends State<VideoTrailerByMovie> {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'iLnmTe5Q2Qw',
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Videos", style: textTheme.titleLarge),
          Text("Trailer [Doblado]"),
          const SizedBox(
            height: 5,
          ),
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.amber,
            progressColors: const ProgressBarColors(
              playedColor: Colors.amber,
              handleColor: Colors.amberAccent,
            ),
            onReady: () {
              // _controller.addListener(listener);
            },
          ),
        ],
      ),
    );
  }
}
