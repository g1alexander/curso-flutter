import 'package:cinemapedia/modules/movies/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/modules/movies/infrastructure/repositories/movie_repository_impl.dart';
import 'package:cinemapedia/modules/movies/presentation/cubits/cubits.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void serviceLocatorInit() {
  getIt.registerSingleton(
      NowPlayingMoviesCubit(MovieRepositoryImpl(MoviedbDatasource())));
  getIt.registerSingleton(
      PopularMoviesCubit(MovieRepositoryImpl(MoviedbDatasource())));
  getIt.registerSingleton(
      UpcomingMoviesCubit(MovieRepositoryImpl(MoviedbDatasource())));
  getIt.registerSingleton(
      TopRatedMoviesCubit(MovieRepositoryImpl(MoviedbDatasource())));
  getIt.registerSingleton(
      MovieInfoCubit(MovieRepositoryImpl(MoviedbDatasource())));
  getIt.registerSingleton(ActorsCubit());
}
