import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const BaliCultureApp());
}

class BaliCultureApp extends StatelessWidget {
  const BaliCultureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BaliCulture',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B1E1E),
          primary: const Color(0xFF8B1E1E),
          secondary: const Color(0xFFD4AF37),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF8B1E1E),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}