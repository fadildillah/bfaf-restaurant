import 'package:bfaf_submisi_restaurant_app/data/model/restaurant_list.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblFavorite = 'favorites';

  Future<Database> _initializeDb() async {
    final path = join(await getDatabasesPath(), 'restaurant.db');
    print('Database path: $path');
    final db = await openDatabase(
      path,
      onCreate: (db, version) async {
        print("Creating database and table...");
        await db.execute(
          '''CREATE TABLE $_tblFavorite (
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            pictureId TEXT,
            city TEXT,
            rating REAL
          )''',
        );
        print("Table $_tblFavorite created.");
      },
      version: 1,
    );
    return db;
  }


  Future<Database?> get database async {
    _database ??= await _initializeDb();
    return _database;
  }

  Future<void> insertFavorite(RestaurantListSummary restaurant) async {
    final db = await database;
    await db!.insert(_tblFavorite, restaurant.toJson());
  }

  Future<List<RestaurantListSummary>> getFavorites() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblFavorite);
    return results.map((res) => RestaurantListSummary.fromJson(res)).toList();
  }

  Future<Map<String, dynamic>?> getFavoriteById(String id) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;
    await db!.delete(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

