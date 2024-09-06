import 'package:cinemapedia/modules/movies/domain/entities/movie.dart';
import 'package:cinemapedia/modules/movies/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/modules/movies/infrastructure/repositories/movie_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_info_state.dart';

class MovieInfoCubit extends Cubit<MovieInfoState> {
  final MovieRepositoryImpl _movieRepository;

  MovieInfoCubit()
      : _movieRepository = MovieRepositoryImpl(MoviedbDatasource()),
        super(const MovieInfoState());

  Future<void> loadMovie(String movieId) async {
    if (state.movieMap[movieId] != null || state.isLoading) return;

    emit(state.copyWith(isLoading: true));

    final movie = await _movieRepository.getMovieById(movieId);

    emit(state.copyWith(
        isLoading: false, movieMap: {...state.movieMap, movieId: movie}));
  }
}
