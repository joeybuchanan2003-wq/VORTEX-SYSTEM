import 'game_genre.dart';

class Armor {
  String name;
  int armorValue;
  String notes;
  bool isEquipped;
  final List<GameGenre> genres;

  Armor({required this.name, this.armorValue = 0, this.notes = '', this.isEquipped = false, this.genres = const []});

  factory Armor.fromJson(Map<String, dynamic> json) => Armor(
    name: json['name'],
    armorValue: json['armorValue'] ?? 0,
    notes: json['notes'] ?? '',
    isEquipped: json['isEquipped'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'armorValue': armorValue,
    'notes': notes,
    'isEquipped': isEquipped,
  };
}