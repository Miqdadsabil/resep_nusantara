import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';
import 'home_screen.dart';
import 'list_screen.dart';

/// Kerangka utama: memuat data sekali, lalu menampilkan BottomNavigationBar.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  late final Future<List<Recipe>> _future = RecipeService().fetchRecipes();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Recipe>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError) {
          return Scaffold(
              body: Center(child: Text('Gagal memuat data: ${snapshot.error}')));
        }
        final recipes = snapshot.data!;
        return Scaffold(
          body: IndexedStack(
            index: _index,
            children: [
              HomeScreen(
                  recipes: recipes,
                  onSeeAll: () => setState(() => _index = 1)),
              ListScreen(recipes: recipes),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _index,
            selectedItemColor: AppTheme.dark,
            onTap: (i) => setState(() => _index = i),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded), label: 'Beranda'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book_rounded), label: 'Resep'),
            ],
          ),
        );
      },
    );
  }
}