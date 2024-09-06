import 'package:animate_do/animate_do.dart';
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

  Future<void> _loadActors(BuildContext context) async {
    await context.read<ActorsCubit>().loadActors(widget.movieId);
  }

  @override
  void initState() {
    super.initState();
    _loadMovie(context);
    _loadActors(context);
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
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(
            movie: movie,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _MovieDetails(
                        movie: movie,
                      ),
                  childCount: 1))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: textTheme.titleLarge,
                    ),
                    Text(movie.overview)
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Chip(
                        label: Text(gender),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ))
            ],
          ),
        ),
        _ActorsByMovie(
          movieId: '${movie.id}',
        ),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}

class _ActorsByMovie extends StatelessWidget {
  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context) {
    final actorsByMovie = context.watch<ActorsCubit>().state.actorMap;

    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator();
    }

    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: actors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8.0),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  actor.name,
                  maxLines: 2,
                ),
                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      expandedHeight: size.height * 0.7,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black87],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.7, 1.0]))),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.black87,
                            Colors.transparent,
                          ],
                          begin: Alignment.topLeft,
                          stops: [0.0, 0.3]))),
            )
          ],
        ),
      ),
    );
  }
}
