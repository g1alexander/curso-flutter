import 'package:cinemapedia/modules/movies/presentation/cubits/cubits.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void serviceLocatorInit() {
  getIt.registerSingleton(NowPlayingMoviesCubit());
  getIt.registerSingleton(PopularMoviesCubit());
  getIt.registerSingleton(UpcomingMoviesCubit());
  getIt.registerSingleton(TopRatedMoviesCubit());
  getIt.registerSingleton(MovieInfoCubit());
}
