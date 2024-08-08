import 'package:flutter/material.dart';
import 'package:widgets_app/presentation/screens/screens.dart';

class MenuItem {
  final String title;
  final String subtitle;
  final String nameRoute;
  final IconData icon;

  const MenuItem(
      {required this.title,
      required this.subtitle,
      required this.nameRoute,
      required this.icon});
}

const appMenuItems = <MenuItem>[
  MenuItem(
      title: "Botones",
      subtitle: "Varios botones en Flutter",
      nameRoute: ButtonsScreen.name,
      icon: Icons.smart_button_outlined),
  MenuItem(
      title: "Tarjetas",
      subtitle: "Un contenedor estilizado",
      nameRoute: CardsScreen.name,
      icon: Icons.credit_card),
  MenuItem(
      title: "ProgressIndicatos",
      subtitle: "Generales y controlados",
      nameRoute: ProgressScreen.name,
      icon: Icons.refresh_rounded)
];
