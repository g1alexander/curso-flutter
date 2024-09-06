import 'package:cinemapedia/modules/movies/domain/entities/actor.dart';
import 'package:cinemapedia/modules/movies/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinemapedia/modules/movies/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'actors_state.dart';

class ActorsCubit extends Cubit<ActorsState> {
  final ActorRepositoryImpl _actorRepository;

  ActorsCubit()
      : _actorRepository = ActorRepositoryImpl(ActorMoviedbDatasource()),
        super(const ActorsState());

  Future<void> loadActors(String movieId) async {
    if (state.actorMap[movieId] != null || state.isLoading) return;

    emit(state.copyWith(isLoading: true));

    final actors = await _actorRepository.getActorsByMovie(movieId);

    emit(state.copyWith(
        isLoading: false, actorMap: {...state.actorMap, movieId: actors}));
  }
}
