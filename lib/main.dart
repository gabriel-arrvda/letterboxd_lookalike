import 'package:flutter/material.dart';
import 'package:letterboxd_lookalike/screens/popular.dart';
import 'package:letterboxd_lookalike/screens/rated.dart';

import 'screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Letterboxd Lookalike',
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/popular': (context) => const Popular(),
        '/rated': (context) => const Rated(),
      },
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xFF2C343F),
            secondary: Color(0xFFF27405),
            onSecondary: Color(0xFF556678),
            tertiary: Color(0xFF00B021),
            primary: Color(0xFF14171C),
            onPrimary: Color(0xFF2C343F)),
      ),
    );
  }
}
