/// Model data resep. `fromJson` memudahkan integrasi API di tahap berikutnya.
class Recipe {
  final int id;
  final String name;
  final String category;
  final String origin;
  final int duration;
  final String difficulty;
  final double rating;
  final String emoji;
  final String imageUrl;
  final String date;
  final String description;
  final List<String> ingredients;
  final List<String> steps;

  const Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.origin,
    required this.duration,
    required this.difficulty,
    required this.rating,
    required this.emoji,
    required this.imageUrl,
    required this.date,
    required this.description,
    required this.ingredients,
    required this.steps,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json['id'] as int,
        name: json['name'] as String,
        category: json['category'] as String,
        origin: json['origin'] as String,
        duration: json['duration'] as int,
        difficulty: json['difficulty'] as String,
        rating: (json['rating'] as num).toDouble(),
        emoji: json['emoji'] as String? ?? '🍽️',
        imageUrl: json['imageUrl'] as String? ?? '',
        date: json['date'] as String,
        description: json['description'] as String,
        ingredients: List<String>.from(json['ingredients'] as List),
        steps: List<String>.from(json['steps'] as List),
      );
}