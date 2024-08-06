import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonsScreen extends StatelessWidget {
  static const name = "buttons_screen";

  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buttons Screens"),
      ),
      body: const _ButtonsView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pop();
        },
        child: const Icon(Icons.arrow_back_ios_new_outlined),
      ),
    );
  }
}

class _ButtonsView extends StatelessWidget {
  const _ButtonsView();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Wrap(
          spacing: 10,
          alignment: WrapAlignment.center,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text("Elevated")),
            const ElevatedButton(
                onPressed: null, child: Text("Elevated disabled")),
            ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.alarm_rounded),
                label: const Text("Elevated icon")),
            FilledButton(onPressed: () {}, child: const Text("filled")),
            FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.ac_unit_rounded),
                label: const Text("filled icon")),
            OutlinedButton(onPressed: () {}, child: const Text("outlined")),
            OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.accessible_forward_outlined),
                label: const Text("outlined icon")),
            TextButton(onPressed: () {}, child: const Text("text")),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.account_circle),
                label: const Text("text icon")),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.app_registration_rounded)),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.app_registration_rounded),
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(colors.primary),
                  iconColor: const MaterialStatePropertyAll(Colors.white)),
            ),
            const _CustomButton()
          ],
        ),
      ),
    );
  }
}

class _CustomButton extends StatelessWidget {
  const _CustomButton();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: colors.primary,
        child: InkWell(
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "hola mundo",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
