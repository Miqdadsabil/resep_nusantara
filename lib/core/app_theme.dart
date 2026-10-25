import 'package:flutter/material.dart';

/// Konsistensi warna & tema seluruh aplikasi.
class AppTheme {
  static const Color dark = Color(0xFF1F3D2B);   // hijau tua (header)
  static const Color cream = Color(0xFFFFF4D6);  // latar
  static const Color accent = Color(0xFFF59E0B); // oranye
  static const Color textGrey = Color(0xFF6B7280);

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: accent, primary: dark),
        scaffoldBackgroundColor: cream,
        appBarTheme: const AppBarTheme(
          backgroundColor: dark,
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
      );
}