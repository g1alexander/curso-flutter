import 'package:cinemapedia/modules/movies/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/modules/movies/presentation/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          HomeScreen(currentChild: navigationShell),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(routes: [
          GoRoute(
              path: '/',
              name: HomeView.name,
              builder: (context, state) => const HomeView(),
              routes: [
                GoRoute(
                  path: "movie/:id",
                  name: MovieScreen.name,
                  builder: (context, state) {
                    final movieId = state.pathParameters['id'] ?? 'no-id';
                    return MovieScreen(movieId: movieId);
                  },
                )
              ]),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/categories',
            name: 'FavoritesView.name',
            builder: (context, state) => const FavoritesView(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/favorites',
            name: FavoritesView.name,
            builder: (context, state) => const FavoritesView(),
          ),
        ])
      ])

  // ShellRoute(
  //     builder: (context, state, child) {
  //       return HomeScreen(childView: child);
  //     },
  //     routes: [
  // GoRoute(
  //     path: '/',
  //     name: HomeView.name,
  //     builder: (context, state) => const HomeView(),
  //     routes: [
  //       GoRoute(
  //         path: "movie/:id",
  //         name: MovieScreen.name,
  //         builder: (context, state) {
  //           final movieId = state.pathParameters['id'] ?? 'no-id';

  //           return MovieScreen(movieId: movieId);
  //         },
  //       )
  //     ]),
  // GoRoute(
  //   path: '/favorites',
  //   name: FavoritesView.name,
  //   builder: (context, state) => const FavoritesView(),
  // ),
  //     ])

  // GoRoute(
  //     path: '/',
  //     name: HomeScreen.name,
  //     builder: (context, state) => const HomeScreen(
  //           childView: FavoritesView(),
  //         ),
  //     routes: [
  // GoRoute(
  //   path: "movie/:id",
  //   name: MovieScreen.name,
  //   builder: (context, state) {
  //     final movieId = state.pathParameters['id'] ?? 'no-id';

  //     return MovieScreen(movieId: movieId);
  //   },
  // )
  //     ]),
]);
