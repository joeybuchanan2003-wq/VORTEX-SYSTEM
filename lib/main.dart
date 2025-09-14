import 'package:flutter/material.dart';
import 'screens/character_list_screen.dart';

// Main function to run the app
void main() {
  runApp(const VertexCharacterSheetApp());
}

// --- MAIN APP WIDGET ---
class VertexCharacterSheetApp extends StatelessWidget {
  const VertexCharacterSheetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VERTEX Character Sheet',
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.cyan,
          scaffoldBackgroundColor: const Color(0xFF1a1a1a),
          cardColor: const Color(0xFF2c2c2c),
          indicatorColor: Colors.cyanAccent,
          appBarTheme: const AppBarTheme(
            color: Color(0xFF2c2c2c),
            elevation: 4,
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.cyan,
            foregroundColor: Colors.black,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                foregroundColor: Colors.black,
              )
          )
      ),
      home: const CharacterListScreen(),
    );
  }
}