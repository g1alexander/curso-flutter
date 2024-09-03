import 'package:cinemapedia/config/bloc/service_locator.dart';
import 'package:cinemapedia/modules/movies/presentation/cubits/cubits.dart';
import 'package:flutter/material.dart';

import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:cinemapedia/config/router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  serviceLocatorInit();
  runApp(const BlocsProviders());
}

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => getIt<NowPlayingMoviesCubit>()),
      BlocProvider(create: (context) => getIt<PopularMoviesCubit>()),
      BlocProvider(create: (context) => getIt<UpcomingMoviesCubit>()),
      BlocProvider(create: (context) => getIt<TopRatedMoviesCubit>())
    ], child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      routerConfig: appRouter,
    );
  }
}
