class Race {
  final String name;
  final String description;
  final Map<String, int> attributeModifiers;
  final List<String> abilities;
  final int bonusSkillPoints;
  final Map<String, int> skillBonuses;

  Race({
    required this.name,
    required this.description,
    this.attributeModifiers = const {},
    this.abilities = const [],
    this.bonusSkillPoints = 0,
    this.skillBonuses = const {},
  });
}