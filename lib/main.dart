import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'screens/main_shell.dart';

void main() => runApp(const ResepApp());

class ResepApp extends StatelessWidget {
  const ResepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resep Nusantara',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const MainShell(),
    );
  }
}