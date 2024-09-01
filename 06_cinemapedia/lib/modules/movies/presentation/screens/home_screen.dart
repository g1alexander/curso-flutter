import 'package:cinemapedia/modules/movies/presentation/cubits/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
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
    final movies = context.watch<MoviesRepositoryCubit>().state.movies;
    final isLoading = context.watch<MoviesRepositoryCubit>().state.isLoading;

    if (isLoading) return const CircularProgressIndicator();

    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];

        return ListTile(
          title: Text(movie.title),
        );
      },
    );
  }
}
