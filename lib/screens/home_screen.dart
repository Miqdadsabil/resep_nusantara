import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../models/category_item.dart';
import '../models/recipe.dart';
import '../widgets/recipe_cards.dart';
import 'list_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Recipe> recipes;
  final VoidCallback onSeeAll;
  const HomeScreen({super.key, required this.recipes, required this.onSeeAll});

  void _openList(BuildContext context, {String? category, String query = ''}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ListScreen(
            recipes: recipes, initialCategory: category, initialQuery: query),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final popular = [...recipes]..sort((a, b) => b.rating.compareTo(a.rating));
    final latest = [...recipes]..sort((a, b) => b.date.compareTo(a.date));

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildHeader(context),
          _sectionTitle('Kategori'),
          SizedBox(
            height: 96,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: kCategories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, i) {
                final c = kCategories[i];
                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => _openList(context, category: c.name),
                  child: SizedBox(
                    width: 68,
                    child: Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppTheme.accent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(c.icon, color: Colors.white, size: 28),
                        ),
                        const SizedBox(height: 6),
                        Text(c.name,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          _sectionTitle('Resep Populer'),
          SizedBox(
            height: 235,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: popular.length > 5 ? 5 : popular.length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (_, i) => PopularCard(recipe: popular[i]),
            ),
          ),
          _sectionTitle('Resep Terbaru', actionLabel: 'Lihat semua'),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Column(
              children: [
                for (final r in latest.take(4)) ...[
                  RecipeTile(recipe: r),
                  const SizedBox(height: 10),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, MediaQuery.of(context).padding.top + 20, 20, 28),
      decoration: const BoxDecoration(
        color: AppTheme.dark,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Selamat Datang',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Mau masak apa hari ini?',
                        style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              CircleAvatar(
                backgroundColor: AppTheme.accent,
                child: Icon(Icons.restaurant_menu, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            textInputAction: TextInputAction.search,
            onSubmitted: (v) => _openList(context, query: v),
            decoration: InputDecoration(
              hintText: 'Cari nama resep...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, {String? actionLabel}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 12, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          if (actionLabel != null)
            TextButton(onPressed: onSeeAll, child: Text(actionLabel)),
        ],
      ),
    );
  }
}