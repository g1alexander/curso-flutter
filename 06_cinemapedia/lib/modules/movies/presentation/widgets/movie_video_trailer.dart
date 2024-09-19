import 'package:cinemapedia/modules/movies/presentation/cubits/cubits.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieVideoTrailer extends StatefulWidget {
  final String movieId;

  const MovieVideoTrailer({super.key, required this.movieId});

  @override
  State<MovieVideoTrailer> createState() => _MovieVideoTrailerState();
}

class _MovieVideoTrailerState extends State<MovieVideoTrailer> {
  var isLoading = false;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _getVideoId(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _getVideoId(BuildContext context) async {
    isLoading = true;
    final keyId =
        await context.read<MovieInfoCubit>().getVideoByMovieId(widget.movieId);

    _controller = YoutubePlayerController(
        initialVideoId: keyId,
        flags: const YoutubePlayerFlags(autoPlay: false, mute: false));

    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Videos", style: textTheme.titleLarge),
          const Text("Trailer [Doblado]"),
          const SizedBox(
            height: 5,
          ),
          isLoading
              ? const CircularProgressIndicator()
              : YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.amber,
                  progressColors: const ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                  ),
                ),
        ],
      ),
    );
  }
}
