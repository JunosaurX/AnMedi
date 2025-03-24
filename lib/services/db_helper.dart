import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/drug_model.dart';

class DBHelper {
  // ✅ Load drug data from Western medicine JSON file
  static Future<List<Drug>> getDrugByName(String name) async {
    try {
      String jsonString = await rootBundle.loadString('assets/drug_info.json');
      Map<String, dynamic> jsonResponse = jsonDecode(jsonString);

      if (!jsonResponse.containsKey('drugs') || jsonResponse['drugs'] == null) {
        throw Exception('No drugs data available in the JSON file');
      }

      List<dynamic> drugsList = jsonResponse['drugs'];

      List<Drug> filteredDrugs = drugsList
          .where((drug) => (drug['name'] as String)
              .toLowerCase()
              .startsWith(name.toLowerCase()))
          .map((data) => Drug.fromJson(data))
          .toList();

      return filteredDrugs;
    } catch (e) {
      print('Error loading drug data: $e');
      throw Exception('Failed to load drug data: $e');
    }
  }

  // ✅ Load drug data from Chinese medicine JSON file
  static Future<List<Drug>> getChineseDrugByName(String name) async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/chinesemed_info.json');
      Map<String, dynamic> jsonResponse = jsonDecode(jsonString);

      if (!jsonResponse.containsKey('drugs') || jsonResponse['drugs'] == null) {
        throw Exception('No Chinese drugs data available in the JSON file');
      }

      List<dynamic> drugsList = jsonResponse['drugs'];

      List<Drug> filteredDrugs = drugsList
          .where((drug) => (drug['name'] as String)
              .toLowerCase()
              .startsWith(name.toLowerCase()))
          .map((data) => Drug.fromJson(data))
          .toList();

      return filteredDrugs;
    } catch (e) {
      print('Error loading Chinese drug data: $e');
      throw Exception('Failed to load Chinese drug data: $e');
    }
  }

  // ✅ Initialize the database for flashcards
  static Future<Database> _getDatabase() async {
    final String dbPath = join(await getDatabasesPath(), 'flashcards.db');

    return openDatabase(
      dbPath,
      version: 3, // 🔥 Increased version to force table recreation
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE flashcards(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT UNIQUE NOT NULL,
            description TEXT NOT NULL,
            side_effects TEXT NOT NULL,
            dosage TEXT NOT NULL,
            uses TEXT NOT NULL
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await db
            .execute('DROP TABLE IF EXISTS flashcards'); // 🚀 Drop old table
        await db.execute('''
          CREATE TABLE flashcards(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT UNIQUE NOT NULL,
            description TEXT NOT NULL,
            side_effects TEXT NOT NULL,
            dosage TEXT NOT NULL,
            uses TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // ✅ Add a drug to the flashcards table (Prevents Duplicates)
  static Future<void> addDrugToFlashcards(Drug drug) async {
    final db = await _getDatabase();
    await db.insert(
      'flashcards',
      {
        'name': drug.name,
        'description': drug.description,
        'side_effects': drug.sideEffects,
        'dosage': drug.dosage,
        'uses': drug.uses,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore, // Prevents duplicates
    );
  }

  // ✅ Retrieve all flashcards
  static Future<List<Drug>> getFlashcards() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('flashcards');

    return List.generate(maps.length, (i) {
      return Drug(
        name: maps[i]['name'],
        description: maps[i]['description'],
        sideEffects: maps[i]['side_effects'],
        dosage: maps[i]['dosage'],
        uses: maps[i]['uses'],
      );
    });
  }

  // ✅ Delete a flashcard from the database
  static Future<void> deleteFlashcard(String drugName) async {
    final db = await _getDatabase();
    await db.delete(
      'flashcards',
      where: 'name = ?',
      whereArgs: [drugName],
    );
  }
}
