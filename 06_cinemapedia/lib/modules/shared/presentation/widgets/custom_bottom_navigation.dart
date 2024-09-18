import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  final StatefulNavigationShell currentChild;
  const CustomBottomNavigation({super.key, required this.currentChild});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        elevation: 0,
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
