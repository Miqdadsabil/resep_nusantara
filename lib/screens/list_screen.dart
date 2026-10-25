import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../models/category_item.dart';
import '../models/recipe.dart';
import '../widgets/recipe_cards.dart';

class ListScreen extends StatefulWidget {
  final List<Recipe> recipes;
  final String? initialCategory;
  final String initialQuery;

  const ListScreen({
    super.key,
    required this.recipes,
    this.initialCategory,
    this.initialQuery = '',
  });

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late String? _category = widget.initialCategory;
  late String _query = widget.initialQuery;
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialQuery);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Recipe> get _filtered => widget.recipes.where((r) {
        final matchCat = _category == null || r.category == _category;
        final matchQuery =
            r.name.toLowerCase().contains(_query.trim().toLowerCase());
        return matchCat && matchQuery;
      }).toList();

  @override
  Widget build(BuildContext context) {
    final items = _filtered;
    return Scaffold(
      appBar: AppBar(title: Text(_category ?? 'Daftar Resep')),
      body: Column(
        children: [
          Container(
            color: AppTheme.dark,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(
              controller: _controller,
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'Cari resep...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 56,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: [
                _chip('Semua', _category == null, () {
                  setState(() => _category = null);
                }),
                for (final c in kCategories)
                  _chip(c.name, _category == c.name, () {
                    setState(() => _category = c.name);
                  }),
              ],
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text('Resep tidak ditemukan 🍽️'))
                : LayoutBuilder(
                    builder: (context, constraints) {
                      // Responsif: layar lebar -> grid, layar sempit -> list.
                      if (constraints.maxWidth >= 600) {
                        return GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 480,
                            mainAxisExtent: 100,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: items.length,
                          itemBuilder: (_, i) => RecipeTile(recipe: items[i]),
                        );
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (_, i) => RecipeTile(recipe: items[i]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, bool selected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        selectedColor: AppTheme.accent,
        onSelected: (_) => onTap(),
      ),
    );
  }
}