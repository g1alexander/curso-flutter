import 'package:cinemapedia/modules/movies/domain/entities/movie.dart';
import 'package:cinemapedia/modules/movies/presentation/cubits/movies/home/movies_cubit.dart';
import 'package:cinemapedia/modules/shared/presentation/delegates/search_movie_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  Icons.movie_outlined,
                  color: colors.primary,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Cinemadia",
                  style: textTheme.titleMedium,
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      final moviesCubit = context.read<MoviesCubit>();

                      showSearch<Movie?>(
                              context: context,
                              delegate: SearchMovieDelegate(
                                  searchMovies:
                                      moviesCubit.movieRepository.searchMovies))
                          .then((movie) {
                        if (movie == null || !context.mounted) return;
                        context.push("/movie/${movie.id}");
                      });
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
          ),
        ));
  }
}