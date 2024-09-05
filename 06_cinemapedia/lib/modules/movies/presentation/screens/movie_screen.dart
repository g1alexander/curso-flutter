import 'package:cinemapedia/modules/movies/domain/entities/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cinemapedia/modules/movies/presentation/cubits/cubits.dart';
import 'package:flutter/material.dart';

class MovieScreen extends StatefulWidget {
  static const name = 'movie-screen';

  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  Future<void> _loadMovie(BuildContext context) async {
    await context.read<MovieInfoCubit>().loadMovie(widget.movieId);
  }

  @override
  void initState() {
    super.initState();
    _loadMovie(context);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie =
        context.watch<MovieInfoCubit>().state.movieMap[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("MovieId ${widget.movieId}"),
      ),
    );
  }
}
