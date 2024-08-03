import 'package:flutter/material.dart';
import 'package:yesnoapp/config/theme/app_theme.dart';
import 'package:yesnoapp/presentation/screens/chat/chat_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme(colorIndex: 3).themeData(),
      home: const ChatScreen(),
    );
  }
}
