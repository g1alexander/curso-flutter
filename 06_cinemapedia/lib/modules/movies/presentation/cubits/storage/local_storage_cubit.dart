import 'package:cinemapedia/modules/movies/domain/entities/movie.dart';
import 'package:cinemapedia/modules/movies/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'local_storage_state.dart';

class LocalStorageCubit extends Cubit<LocalStorageState> {
  final LocalStorageRepositoryImpl _localStorageRepository;

  LocalStorageCubit(this._localStorageRepository)
      : super(const LocalStorageState());

  Future<void> toggleFavorite(Movie movie) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true));

    await _localStorageRepository.toggleFavorite(movie);

    emit(state.copyWith(isLoading: false, isFavorite: !state.isFavorite));
  }

  Future<void> isFavorite(int movieId) async {
    emit(state.copyWith(isLoading: true));

    final isFavorite = await _localStorageRepository.isMovieFavorite(movieId);

    emit(state.copyWith(isLoading: false, isFavorite: isFavorite));
  }
}
