import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/modules/movies/domain/entities/movie.dart';
import 'package:cinemapedia/modules/movies/presentation/cubits/storage/local_storage_cubit.dart';
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

class _CustomSliverAppBar extends StatefulWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  State<_CustomSliverAppBar> createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<_CustomSliverAppBar> {
  Future<void> isFavorite(BuildContext context, int movieId) async {
    await context.read<LocalStorageCubit>().isFavorite(movieId);
  }

  @override
  void initState() {
    super.initState();
    isFavorite(context, widget.movie.id);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isFavorite = context.watch<LocalStorageCubit>().state.isFavorite;

    return SliverAppBar(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      expandedHeight: size.height * 0.7,
      actions: [
        IconButton(
          onPressed: () async {
            await context
                .read<LocalStorageCubit>()
                .toggleFavorite(widget.movie);
          },
          icon: isFavorite
              ? const Icon(
                  Icons.favorite_rounded,
                  color: Colors.red,
                )
              : const Icon(Icons.favorite_border),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                widget.movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            const _CustomGradient(
                colors: [Colors.black54, Colors.transparent],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.0, .2]),
            const _CustomGradient(
              colors: [Colors.transparent, Colors.black54],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.8, 1.0],
            ),
            const _CustomGradient(
              colors: [
                Colors.black54,
                Colors.transparent,
              ],
              begin: Alignment.topLeft,
              stops: [0.0, 0.3],
            )
          ],
        ),
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient(
      {this.end = Alignment.centerRight,
      required this.begin,
      required this.stops,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: colors, begin: begin, end: end, stops: stops))),
    );
  }
}
