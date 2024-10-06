import 'package:shop_loc/model/place_model.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'places.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE places(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            vicinity TEXT,
            lat REAL,
            lng REAL,
            distance REAL,
            rating REAL,
            userRatingsTotal INTEGER,
            isOpen INTEGER,
            imageUrl TEXT,
            description TEXT
          )
          ''',
        );
      },
    );
  }

  Future<void> insertPlace(Place place) async {
    final db = await database;
    await db.insert(
      'places',
      place.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Place>> getPlaces() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('places');

    return List.generate(maps.length, (i) {
      return Place.fromMap(maps[i]);
    });
  }

  Future<void> deleteAllPlaces() async {
    final db = await database;
    await db.delete('places');
  }
}
