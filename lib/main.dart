import 'package:flutter/material.dart';
import 'package:f02/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.light(surface: Color(0xFFE64D3D)),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFFF5A59D),
          ),
        ),
        cardColor: const Color(0xFFFFFFFF),
      ),
      home: const HomeScreen(),
    );
  }
}
