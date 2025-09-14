import 'game_genre.dart';

class Weapon {
  String name;
  String damage;
  String notes;
  final List<GameGenre> genres;

  Weapon({required this.name, this.damage = '', this.notes = '', this.genres = const []});

  factory Weapon.fromJson(Map<String, dynamic> json) => Weapon(
    name: json['name'],
    damage: json['damage'] ?? '',
    notes: json['notes'] ?? '',
    // Genre is for game data, not saved with character
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'damage': damage,
    'notes': notes,
  };
}