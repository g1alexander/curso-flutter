import 'package:cinemapedia/modules/movies/presentation/cubits/movies_repository_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void serviceLocatorInit() {
  getIt.registerSingleton(MoviesRepositoryCubit());
}
