import 'game_genre.dart';

class Spell {
  String name;
  int spCost;
  String description;
  final List<GameGenre> genres;

  Spell({required this.name, this.spCost = 0, this.description = '', this.genres = const []});

  factory Spell.fromJson(Map<String, dynamic> json) => Spell(
    name: json['name'],
    spCost: json['spCost'] ?? 0,
    description: json['description'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'spCost': spCost,
    'description': description,
  };
}