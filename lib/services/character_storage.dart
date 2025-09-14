import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/character.dart';

class CharacterStorage {
  static const _listKey = 'characterList';

  static Future<void> saveCharacter(Character character) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(character.id, jsonEncode(character.toJson()));

    List<String> characterList = prefs.getStringList(_listKey) ?? [];
    if (!characterList.contains(character.id)) {
      characterList.add(character.id);
      await prefs.setStringList(_listKey, characterList);
    }
  }

  static Future<List<Character>> loadCharacterSummaries() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> characterList = prefs.getStringList(_listKey) ?? [];
    List<Character> characters = [];
    for (String id in characterList) {
      final charJson = prefs.getString(id);
      if (charJson != null) {
        characters.add(Character.fromJson(jsonDecode(charJson)));
      }
    }
    return characters;
  }

  static Future<void> deleteCharacter(String characterId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(characterId);
    List<String> characterList = prefs.getStringList(_listKey) ?? [];
    characterList.remove(characterId);
    await prefs.setStringList(_listKey, characterList);
  }
}