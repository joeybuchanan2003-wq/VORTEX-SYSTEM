import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/character_storage.dart';
import 'character_creation_wizard.dart';
import 'character_sheet_screen.dart';


class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  _CharacterListScreenState createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  late Future<List<Character>> _charactersFuture;

  @override
  void initState() {
    super.initState();
    _charactersFuture = CharacterStorage.loadCharacterSummaries();
  }

  void _refreshList() {
    setState(() {
      _charactersFuture = CharacterStorage.loadCharacterSummaries();
    });
  }

  void _navigateToSheet(Character character) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CharacterSheetScreen(character: character),
    )).then((_) => _refreshList());
  }

  void _navigateToCreator() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const CharacterCreationWizard(),
    )).then((_) => _refreshList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VERTEX Characters'),
      ),
      body: FutureBuilder<List<Character>>(
        future: _charactersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error loading characters: ${snapshot.error}"));
          }
          final characters = snapshot.data ?? [];
          if (characters.isEmpty) {
            return const Center(
              child: Text(
                "No characters found.\nTap the '+' button to create one!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            itemCount: characters.length,
            itemBuilder: (context, index) {
              final char = characters[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: ListTile(
                  title: Text(char.name),
                  subtitle: Text("${char.raceName} ${char.professionName}"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => _navigateToSheet(char),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCreator,
        tooltip: 'Create New Character',
        child: const Icon(Icons.add),
      ),
    );
  }
}