import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../models/recipe.dart';
import '../services/favorite_store.dart';
import '../widgets/recipe_image.dart';

class DetailScreen extends StatelessWidget {
  final Recipe recipe;
  const DetailScreen({super.key, required this.recipe});

  static void open(BuildContext context, Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailScreen(recipe: recipe)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 280,
            title: Text(recipe.name),
            actions: [
              ValueListenableBuilder<Set<int>>(
                valueListenable: FavoriteStore.ids,
                builder: (_, ids, __) {
                  final fav = ids.contains(recipe.id);
                  return IconButton(
                    icon: Icon(
                      fav ? Icons.favorite : Icons.favorite_border,
                      color: fav ? Colors.redAccent : Colors.white,
                    ),
                    onPressed: () => FavoriteStore.toggle(recipe.id),
                  );
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: RecipeImage(recipe: recipe),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('${recipe.origin} • ${recipe.category}',
                      style: const TextStyle(color: AppTheme.textGrey)),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _info(Icons.timer_outlined, '${recipe.duration} menit'),
                      _info(Icons.speed, recipe.difficulty),
                      _info(Icons.star_rounded, '${recipe.rating}'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(recipe.description,
                      style: const TextStyle(fontSize: 14, height: 1.5)),
                  _heading('Bahan-bahan'),
                  for (final item in recipe.ingredients)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.check_circle,
                              size: 18, color: AppTheme.dark),
                          const SizedBox(width: 10),
                          Expanded(child: Text(item)),
                        ],
                      ),
                    ),
                  _heading('Langkah Memasak'),
                  for (var i = 0; i < recipe.steps.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: AppTheme.accent,
                            child: Text('${i + 1}',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                              child: Text(recipe.steps[i],
                                  style: const TextStyle(height: 1.4))),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _heading(String text) => Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 8),
        child: Text(text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      );

  Widget _info(IconData icon, String label) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppTheme.accent),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontSize: 13)),
          ],
        ),
      );
}