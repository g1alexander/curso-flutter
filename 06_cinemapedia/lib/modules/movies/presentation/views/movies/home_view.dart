import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/modules/shared/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/modules/movies/presentation/cubits/cubits.dart';
import 'package:cinemapedia/modules/movies/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  static const name = 'home-view';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<void> _loadNextPage(BuildContext context) async {
    await context.read<MoviesCubit>().loadNextPageNowPlaying();
    if (!context.mounted) return;
    await context.read<MoviesCubit>().loadNextPagePopular();
    if (!context.mounted) return;
    await context.read<MoviesCubit>().loadNextPageUpcoming();
    if (!context.mounted) return;
    await context.read<MoviesCubit>().loadNextPageTopRated();
  }

  @override
  void initState() {
    super.initState();
    _loadNextPage(context);
  }

  @override
  Widget build(BuildContext context) {
    final moviesCubit = context.watch<MoviesCubit>();

    final step1 = moviesCubit.getIsEmpty('nowPlayingMovies');
    final step2 = moviesCubit.getIsEmpty('popularMovies');
    final step3 = moviesCubit.getIsEmpty('upcomingMovies');
    final step4 = moviesCubit.getIsEmpty('topRatedMovies');

    final isLoading = step1 || step2 || step3 || step4;

    if (isLoading) return const FullScreenLoader();

    final nowPlayingMovies = moviesCubit.state.nowPlayingMovies;
    final getMoviesSlideshow = context.read<MoviesCubit>().getMoviesSlideshow;

    final popularMovies = moviesCubit.state.popularMovies;
    final upcomingMovies = moviesCubit.state.upcomingMovies;
    final topRatedMovies = moviesCubit.state.topRatedMovies;

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.symmetric(horizontal: 10),
            title: CustomAppbar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            children: [
              MoviesSlideshow(movies: getMoviesSlideshow),
              MovieHorizontalListview(
                movies: nowPlayingMovies,
                title: "En cines",
                subTitle: HumanFormats.date(DateTime.now()),
                loadNextPage: () =>
                    context.read<MoviesCubit>().loadNextPageNowPlaying(),
              ),
              MovieHorizontalListview(
                movies: upcomingMovies,
                title: "Próximamente",
                subTitle: 'En este mes',
                loadNextPage: () =>
                    context.read<MoviesCubit>().loadNextPageUpcoming(),
              ),
              MovieHorizontalListview(
                movies: popularMovies,
                title: "Populares",
                loadNextPage: () =>
                    context.read<MoviesCubit>().loadNextPagePopular(),
              ),
              MovieHorizontalListview(
                movies: topRatedMovies,
                title: "Mejor calificadas",
                subTitle: 'De todos los tiempos',
                loadNextPage: () =>
                    context.read<MoviesCubit>().loadNextPageTopRated(),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          );
        }, childCount: 1))
      ],
    );
  }
}
