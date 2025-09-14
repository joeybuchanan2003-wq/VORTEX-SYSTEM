class RecommendedBuild {
  final String professionName;
  final Map<String, int> attributes; // The final attribute scores before racial mods
  final Map<String, int> skillPointsToAdd; // Points to add on top of base

  RecommendedBuild({
    required this.professionName,
    required this.attributes,
    required this.skillPointsToAdd,
  });
}