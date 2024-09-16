import 'package:cinemapedia/modules/movies/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinemapedia/modules/movies/infrastructure/datasources/isar_datasource.dart';
import 'package:cinemapedia/modules/movies/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/modules/movies/infrastructure/repositories/actor_repository_impl.dart';
import 'package:cinemapedia/modules/movies/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:cinemapedia/modules/movies/infrastructure/repositories/movie_repository_impl.dart';
import 'package:cinemapedia/modules/movies/presentation/cubits/cubits.dart';
import 'package:cinemapedia/modules/movies/presentation/cubits/storage/storage_movies_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void serviceLocatorInit() {
  getIt
      .registerSingleton(MoviesCubit(MovieRepositoryImpl(MoviedbDatasource())));
  getIt.registerSingleton(
      MovieInfoCubit(MovieRepositoryImpl(MoviedbDatasource())));
  getIt.registerSingleton(
      ActorsCubit(ActorRepositoryImpl(ActorMoviedbDatasource())));
  getIt
      .registerSingleton(SearchCubit(MovieRepositoryImpl(MoviedbDatasource())));
  getIt.registerSingleton(
      StorageMoviesCubit(LocalStorageRepositoryImpl(IsarDatasource())));
}
