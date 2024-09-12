import 'package:go_router/go_router.dart';
// import 'package:cinemapedia/modules/movies/presentation/views/views.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  final StatefulNavigationShell currentChild;
  const CustomBottomNavigation({super.key, required this.currentChild});

  // int getCurrentIndex(BuildContext context) {
  //   final String location = GoRouterState.of(context).fullPath ?? '';

  //   switch (location) {
  //     case '/':
  //       return 0;
  //     case '/categories':
  //       return 1;
  //     case '/favorites':
  //       return 2;
  //     default:
  //       return 0;
  //   }
  // }

  // void onItemTapped(BuildContext context, int index) {
  //   switch (index) {
  //     case 0:
  //       context.goNamed(HomeView.name);
  //       break;
  //     case 1:
  //       context.goNamed(HomeView.name);
  //     case 2:
  //       context.goNamed(FavoritesView.name);
  //     default:
  //       context.goNamed(HomeView.name);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        elevation: 0,
        // onTap: (index) => onItemTapped(context, index),
        onTap: (index) => currentChild.goBranch(index),
        currentIndex: currentChild.currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.label_outline), label: 'Categorías'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline), label: 'Favoritos')
        ]);
  }
}
