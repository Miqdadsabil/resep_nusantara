import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../models/recipe.dart';
import '../screens/detail_screen.dart';
import 'recipe_image.dart';

/// Kartu horizontal untuk daftar (Terbaru & Daftar Resep).
class RecipeTile extends StatelessWidget {
  final Recipe recipe;
  const RecipeTile({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => DetailScreen.open(context, recipe),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              RecipeImage(
                recipe: recipe,
                width: 72,
                height: 72,
                radius: BorderRadius.circular(12),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(recipe.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 4),
                    Text('${recipe.origin} • ${recipe.category}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12, color: AppTheme.textGrey)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.timer_outlined,
                            size: 14, color: AppTheme.textGrey),
                        const SizedBox(width: 4),
                        Text('${recipe.duration} mnt',
                            style: const TextStyle(fontSize: 12)),
                        const SizedBox(width: 10),
                        const Icon(Icons.star_rounded,
                            size: 16, color: AppTheme.accent),
                        const SizedBox(width: 2),
                        Text('${recipe.rating}',
                            style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppTheme.textGrey),
            ],
          ),
        ),
      ),
    );
  }
}

/// Kartu vertikal untuk carousel "Resep Populer".
class PopularCard extends StatelessWidget {
  final Recipe recipe;
  const PopularCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Card(
        color: Colors.white,
        elevation: 2,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          onTap: () => DetailScreen.open(context, recipe),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RecipeImage(
                  recipe: recipe, width: double.infinity, height: 140),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(recipe.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded,
                            size: 16, color: AppTheme.accent),
                        Text(' ${recipe.rating}  •  ${recipe.duration} mnt',
                            style: const TextStyle(
                                fontSize: 12, color: AppTheme.textGrey)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}