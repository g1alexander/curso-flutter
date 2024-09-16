import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:cinemapedia/modules/movies/presentation/widgets/widgets.dart';
import 'package:cinemapedia/modules/movies/presentation/cubits/storage/storage_movies_cubit.dart';

class FavoritesView extends StatefulWidget {
  static const name = 'favorites-view';
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  Future<void> loadNextPage(BuildContext context) async {
    await context.read<StorageMoviesCubit>().loadNextPage();
  }

  @override
  void initState() {
    super.initState();
    loadNextPage(context);
  }

  @override
  Widget build(BuildContext context) {
    final movies = context.watch<StorageMoviesCubit>().getFavoriteMovies;

    if (movies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outline_sharp,
              color: colors.primary,
              size: 60,
            ),
            Text(
              'Ohhh no!',
              style: TextStyle(fontSize: 30, color: colors.primary),
            ),
            const Text(
              "No tiene películas favoritas",
              style: TextStyle(fontSize: 20, color: Colors.black45),
            ),
            const SizedBox(
              height: 20,
            ),
            FilledButton.tonal(
                onPressed: () => context.go('/home/0'),
                child: const Text("Empieza a buscar"))
          ],
        ),
      );
    }

    return Scaffold(
        body: MovieMasonry(
      movies: movies,
      loadNextPage: loadNextPage,
    ));
  }
}
