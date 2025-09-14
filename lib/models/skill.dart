import 'character.dart';

class Skill {
  String name;
  String governingAttribute;
  int points;
  bool improvementCheck;

  Skill({
    required this.name,
    required this.governingAttribute,
    this.points = 0,
    this.improvementCheck = false,
  });

  int getRating(Character character) {
    String baseAttrKey = governingAttribute.split('/').first;
    int baseValue = character.getAttr(baseAttrKey);
    return baseValue + points;
  }

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
    name: json['name'],
    governingAttribute: json['governingAttribute'],
    points: json['points'],
    improvementCheck: json['improvementCheck'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'governingAttribute': governingAttribute,
    'points': points,
    'improvementCheck': improvementCheck,
  };
}