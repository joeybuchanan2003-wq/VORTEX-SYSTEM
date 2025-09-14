import '../services/game_data.dart';
import 'attribute.dart';
import 'game_genre.dart';
import 'skill.dart';
import 'weapon.dart';
import 'armor.dart';
import 'spell.dart';

class Character {
  String id;
  String name;
  String raceName;
  String professionName;
  String concept;
  GameGenre genre;

  Map<String, Attribute> attributes;
  List<Skill> skills;

  List<Weapon> weapons;
  List<Armor> armor;
  List<Spell> spells;

  String inventory;
  String notes;
  String majorWounds;

  int? currentHp;
  int? currentRp;
  int? currentLuck;

  Character({
    String? id,
    required this.name,
    required this.raceName,
    required this.professionName,
    required this.concept,
    required this.genre,
    required this.attributes,
    required this.skills,
    List<Weapon>? weapons,
    List<Armor>? armor,
    List<Spell>? spells,
    this.inventory = '',
    this.notes = '',
    this.majorWounds = '',
    this.currentHp,
    this.currentRp,
    this.currentLuck,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        weapons = weapons ?? [],
        armor = armor ?? [],
        spells = spells ?? [];

  int get maxHp => (attributes['CON']!.value + 5) + (GameData.races.firstWhere((r) => r.name == raceName, orElse: () => GameData.races.first).abilities.contains("Toughness: +2 bonus HP.") ? 2 : 0);
  int get maxRp => attributes['WIL']!.value;
  int get maxLuck => (attributes['WIL']!.value / 5).floor();
  int get armorValue {
    int totalAv = 0;
    final race = GameData.races.firstWhere((r) => r.name == raceName, orElse: () => GameData.races.first);
    if (race.abilities.contains("Natural Armor: Provides a natural AV of 1.")) {
      totalAv += 1;
    }
    for (var piece in armor) {
      if (piece.isEquipped) {
        totalAv += piece.armorValue;
      }
    }
    return totalAv;
  }

  int getAttr(String key) => attributes[key]?.value ?? 10;

  factory Character.fromJson(Map<String, dynamic> json) {
    final tempAttributes = (json['attributes'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, Attribute.fromJson(value)),
    );
    final maxHpFallback = tempAttributes['CON']!.value + 5;
    final maxRpFallback = tempAttributes['WIL']!.value;
    final maxLuckFallback = (tempAttributes['WIL']!.value / 5).floor();

    return Character(
      id: json['id'],
      name: json['name'],
      raceName: json['raceName'] ?? 'Human',
      professionName: json['professionName'] ?? 'Adventurer',
      concept: json['concept'],
      genre: GameGenre.values.firstWhere((e) => e.toString() == json['genre'], orElse: () => GameGenre.modern),
      attributes: tempAttributes,
      skills: (json['skills'] as List).map((i) => Skill.fromJson(i)).toList(),
      weapons: (json['weapons'] as List? ?? []).map((i) => Weapon.fromJson(i)).toList(),
      armor: (json['armor'] as List? ?? []).map((i) => Armor.fromJson(i)).toList(),
      spells: (json['spells'] as List? ?? []).map((i) => Spell.fromJson(i)).toList(),
      inventory: json['inventory'] ?? '',
      notes: json['notes'] ?? '',
      majorWounds: json['majorWounds'] ?? '',
      currentHp: json['currentHp'] ?? maxHpFallback,
      currentRp: json['currentRp'] ?? maxRpFallback,
      currentLuck: json['currentLuck'] ?? maxLuckFallback,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'raceName': raceName,
    'professionName': professionName,
    'concept': concept,
    'genre': genre.toString(),
    'attributes': attributes.map((key, value) => MapEntry(key, value.toJson())),
    'skills': skills.map((i) => i.toJson()).toList(),
    'weapons': weapons.map((i) => i.toJson()).toList(),
    'armor': armor.map((i) => i.toJson()).toList(),
    'spells': spells.map((i) => i.toJson()).toList(),
    'inventory': inventory,
    'notes': notes,
    'majorWounds': majorWounds,
    'currentHp': currentHp,
    'currentRp': currentRp,
    'currentLuck': currentLuck,
  };
}