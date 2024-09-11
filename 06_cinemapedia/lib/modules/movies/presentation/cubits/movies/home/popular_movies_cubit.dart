import 'package:cinemapedia/modules/movies/domain/entities/movie.dart';
import 'package:cinemapedia/modules/movies/infrastructure/repositories/movie_repository_impl.dart';
import 'package:cinemapedia/modules/movies/presentation/cubits/movies/home/movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesCubit extends Cubit<MovieState> {
  final MovieRepositoryImpl _movieRepository;
  PopularMoviesCubit(this._movieRepository) : super(const MovieState());

  Future<void> loadNextPage() async {
    if (state.isLoading) return;

    emit(state.copyWith(currentPage: state.currentPage + 1, isLoading: true));

    final List<Movie> movies =
        await _movieRepository.getPopular(page: state.currentPage);

    emit(
        state.copyWith(movies: [...state.movies, ...movies], isLoading: false));
  }

  bool get getIsEmpty => state.movies.isEmpty;
}
