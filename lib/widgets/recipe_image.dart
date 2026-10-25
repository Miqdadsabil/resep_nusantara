import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../models/recipe.dart';

/// Menampilkan foto (network/asset); fallback ke emoji bila kosong/gagal.
class RecipeImage extends StatelessWidget {
  final Recipe recipe;
  final double? width;
  final double? height;
  final BorderRadius radius;

  const RecipeImage({
    super.key,
    required this.recipe,
    this.width,
    this.height,
    this.radius = BorderRadius.zero,
  });

  Widget _fallback() => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFBBF24), AppTheme.accent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: FittedBox(child: Text(recipe.emoji)),
      );

  @override
  Widget build(BuildContext context) {
    final url = recipe.imageUrl;
    Widget child;
    if (url.startsWith('http')) {
      child = Image.network(url,
          fit: BoxFit.cover, errorBuilder: (_, __, ___) => _fallback());
    } else if (url.startsWith('assets')) {
      child = Image.asset(url,
          fit: BoxFit.cover, errorBuilder: (_, __, ___) => _fallback());
    } else {
      child = _fallback();
    }
    return ClipRRect(
      borderRadius: radius,
      child: SizedBox(width: width, height: height, child: child),
    );
  }
}