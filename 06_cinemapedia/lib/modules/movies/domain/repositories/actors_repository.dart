import 'package:cinemapedia/modules/movies/domain/entities/actor.dart';

abstract class ActorsRepository {
  Future<List<Actor>> getActorsByMovie(String movieId);
}
