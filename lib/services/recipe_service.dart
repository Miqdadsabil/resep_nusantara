import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/recipe.dart';

/// Sumber data. Saat ini membaca JSON lokal.
/// Tahap API: ganti isi fetchRecipes() dengan http.get(Uri.parse(url))
/// lalu jsonDecode(response.body). UI tidak perlu diubah.
class RecipeService {
  Future<List<Recipe>> fetchRecipes() async {
    final raw = await rootBundle.loadString('assets/data/recipes.json');
    final List<dynamic> data = jsonDecode(raw) as List<dynamic>;
    return data
        .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}