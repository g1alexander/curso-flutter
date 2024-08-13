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
      title: "Riverpod Counter",
      subtitle: "intro riverpod state management",
      nameRoute: CounterScreen.name,
      icon: Icons.star),
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
      icon: Icons.refresh_rounded),
  MenuItem(
      title: "Snackbars y dialogos",
      subtitle: "indicadores en pantalla",
      nameRoute: SnackbarScreen.name,
      icon: Icons.info_outlined),
  MenuItem(
      title: "Animated container",
      subtitle: "stateful widget animado",
      nameRoute: AnimatedScreen.name,
      icon: Icons.check_box_outlined),
  MenuItem(
      title: "Ui controls + tiles",
      subtitle: "una serie de controles de flutter",
      nameRoute: UiControlsScreen.name,
      icon: Icons.car_rental_outlined),
  MenuItem(
      title: "Intro a la App",
      subtitle: "pequeño tutorial introductorio",
      nameRoute: AppTutorialScreen.name,
      icon: Icons.accessible_rounded),
  MenuItem(
      title: "InfiniteScroll y Pull",
      subtitle: "listas infinitas y pull to refresh",
      nameRoute: InfiniteScrollScreen.name,
      icon: Icons.list_alt_outlined),
  MenuItem(
      title: "Theme changer",
      subtitle: "cambiar tema",
      nameRoute: ThemeChangerScreen.name,
      icon: Icons.color_lens_outlined)
];
