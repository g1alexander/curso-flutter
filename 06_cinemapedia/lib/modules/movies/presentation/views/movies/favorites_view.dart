import 'package:flutter/material.dart';

class FavoritesView extends StatelessWidget {
  static const name = 'favorites-view';
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("favorites"),
      ),
      body: Text("hhhh"),
    );
  }
}
