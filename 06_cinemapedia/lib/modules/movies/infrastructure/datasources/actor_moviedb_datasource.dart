import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/modules/movies/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/modules/movies/domain/entities/actor.dart';
import 'package:cinemapedia/modules/movies/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/modules/movies/infrastructure/models/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMoviedbDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      }));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    final creditsResponse = CreditsResponse.fromJson(response.data);

    final List<Actor> actors = creditsResponse.cast
        .map((actor) => ActorMapper.castToEntity(actor))
        .toList();

    return actors;
  }
}
