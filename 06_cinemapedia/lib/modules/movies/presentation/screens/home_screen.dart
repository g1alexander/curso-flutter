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
  Future<void> _loadNextPage(BuildContext context) async {
    await context.read<MoviesRepositoryCubit>().loadNextPage();
  }

  @override
  void initState() {
    super.initState();
    _loadNextPage(context);
  }

  @override
  Widget build(BuildContext context) {
    final moviesRepository = context.watch<MoviesRepositoryCubit>();

    final movies = moviesRepository.state.movies;
    final getMoviesSlideshow = moviesRepository.getMoviesSlideshow;
    final isLoading = moviesRepository.state.isLoading;

    if (isLoading) return const CircularProgressIndicator();

    return Column(
      children: [
        const CustomAppbar(),
        MoviesSlideshow(movies: getMoviesSlideshow),
        MovieHorizontalListview(
          movies: movies,
          title: "En cines",
          subTitle: 'Lunes 20',
        )
      ],
    );
  }
}
