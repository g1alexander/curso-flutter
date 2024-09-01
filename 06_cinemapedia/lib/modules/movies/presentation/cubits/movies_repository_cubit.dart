import 'package:cinemapedia/modules/movies/domain/entities/movie.dart';
import 'package:cinemapedia/modules/movies/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/modules/movies/infrastructure/repositories/movie_repository_impl.dart';
import 'package:cinemapedia/modules/movies/presentation/cubits/movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesRepositoryCubit extends Cubit<MovieState> {
  final MovieRepositoryImpl _movieRepository;
  MoviesRepositoryCubit()
      : _movieRepository = MovieRepositoryImpl(MoviedbDatasource()),
        super(const MovieState());

  Future<void> loadNextPage() async {
    emit(state.copyWith(currentPage: state.currentPage + 1, isLoading: true));

    final List<Movie> movies =
        await _movieRepository.getNowPlaying(page: state.currentPage);

    emit(
        state.copyWith(movies: [...state.movies, ...movies], isLoading: false));
  }
}
