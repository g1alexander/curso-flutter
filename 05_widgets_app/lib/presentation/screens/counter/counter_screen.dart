import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/counter_provider.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

class CounterScreen extends ConsumerWidget {
  static const String name = "counter_screen";

  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int value = ref.watch(counterProvider);
    final bool isDarkMode = ref.watch(isDarkmodeProvider);

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter Screen"),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(isDarkmodeProvider.notifier).update((state) => !state);
              },
              icon: Icon(isDarkMode
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined)),
        ],
      ),
      body: Center(
        child: Text(
          "Valor $value",
          style: textTheme.titleLarge,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ref.read(counterProvider.notifier).state++;
          ref.read(counterProvider.notifier).update((state) => state + 1);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
