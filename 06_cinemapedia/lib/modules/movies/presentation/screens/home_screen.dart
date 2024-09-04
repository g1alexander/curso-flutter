import 'package:cinemapedia/modules/movies/presentation/cubits/cubits.dart';
import 'package:cinemapedia/modules/movies/presentation/widgets/widgets.dart';
import 'package:cinemapedia/modules/shared/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  Future<void> _nowPlayingloadNextPage(BuildContext context) async {
    await context.read<NowPlayingMoviesCubit>().loadNextPage();
  }

  Future<void> _popularMoviesloadNextPage(BuildContext context) async {
    await context.read<PopularMoviesCubit>().loadNextPage();
  }

  Future<void> _upcommingMoviesloadNextPage(BuildContext context) async {
    await context.read<UpcomingMoviesCubit>().loadNextPage();
  }

  Future<void> _topRatedMoviesloadNextPage(BuildContext context) async {
    await context.read<TopRatedMoviesCubit>().loadNextPage();
  }

  @override
  void initState() {
    super.initState();
    _nowPlayingloadNextPage(context);
    _popularMoviesloadNextPage(context);
    _upcommingMoviesloadNextPage(context);
    _topRatedMoviesloadNextPage(context);
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMoviesCubit = context.watch<NowPlayingMoviesCubit>();
    final popularMoviesCubit = context.watch<PopularMoviesCubit>();
    final upcomingMoviesCubit = context.watch<UpcomingMoviesCubit>();
    final topRatedMoviesCubit = context.watch<TopRatedMoviesCubit>();

    final step1 = nowPlayingMoviesCubit.getIsEmpty;
    final step2 = popularMoviesCubit.getIsEmpty;
    final step3 = upcomingMoviesCubit.getIsEmpty;
    final step4 = topRatedMoviesCubit.getIsEmpty;

    final isLoading = step1 || step2 || step3 || step4;

    if (isLoading) return const FullScreenLoader();

    final nowPlayingMovies = nowPlayingMoviesCubit.state.movies;
    final getMoviesSlideshow =
        context.read<NowPlayingMoviesCubit>().getMoviesSlideshow;

    final popularMovies = popularMoviesCubit.state.movies;
    final upcomingMovies = upcomingMoviesCubit.state.movies;
    final topRatedMovies = topRatedMoviesCubit.state.movies;

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
              // CustomAppbar(),
              MoviesSlideshow(movies: getMoviesSlideshow),
              MovieHorizontalListview(
                movies: nowPlayingMovies,
                title: "En cines",
                subTitle: 'Lunes 20',
                loadNextPage: () =>
                    context.read<NowPlayingMoviesCubit>().loadNextPage(),
              ),
              MovieHorizontalListview(
                movies: upcomingMovies,
                title: "Próximamente",
                subTitle: 'En este mes',
                loadNextPage: () =>
                    context.read<UpcomingMoviesCubit>().loadNextPage(),
              ),
              MovieHorizontalListview(
                movies: popularMovies,
                title: "Populares",
                loadNextPage: () =>
                    context.read<PopularMoviesCubit>().loadNextPage(),
              ),
              MovieHorizontalListview(
                movies: topRatedMovies,
                title: "Mejor calificadas",
                subTitle: 'De todos los tiempos',
                loadNextPage: () =>
                    context.read<TopRatedMoviesCubit>().loadNextPage(),
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
