import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

// listado de colores inmutable
final isDarkmodeProvider = StateProvider((ref) => false);

// un simple boolean
final colorListProvider = Provider((ref) => colorList);

// un simple int
final selectedColorProvider = StateProvider((ref) => 0);

// un objecto de tipo AppTheme custom
final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, AppTheme>((ref) => ThemeNotifier());

// controller o notifier
class ThemeNotifier extends StateNotifier<AppTheme> {
  // ThemeNotifier(super.state);
  // state = estado = new AppTheme()
  ThemeNotifier() : super(AppTheme());

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void changeColorIndex(int colorIndex) {
    state = state.copyWith(selectedColor: colorIndex);
  }
}
