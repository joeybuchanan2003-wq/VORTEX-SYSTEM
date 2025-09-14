import 'game_genre.dart';

class Profession {
  final String name;
  final String description;
  final List<String> professionalSkills;
  final GameGenre genre;
  final List<String> startingGear;

  Profession({
    required this.name,
    required this.description,
    required this.professionalSkills,
    required this.genre,
    this.startingGear = const [],
  });
}