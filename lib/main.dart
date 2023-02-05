import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:co_ride/globals.dart';
import 'package:co_ride/pages/auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Co-Ride',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: accentColor,
        ),
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: const AuthPage(),
    );
  }
}
