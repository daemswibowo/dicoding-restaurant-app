import 'package:flutter/foundation.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static late Database _database;
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  static const String _tableName = 'favourites';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurant.db',
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
               id VARCHAR PRIMARY KEY,
               name VARCHAR,
               description VARCHAR,
               picture_id VARCHAR,
               city VARCHAR,
               rating FLOAT
             )''',
        );
      },
      version: 1,
    );

    return db;
  }

  Future<void> insertFavourite(Restaurant restaurant) async {
    final Database db = await database;
    await db.insert(_tableName, restaurant.toMap());
    if (kDebugMode) {
      print('Data saved');
    }
  }

  Future<List<Restaurant>> getRestaurants() async {
    final Database db = await database;
    List<Map<String, dynamic>> rows = await db.query(_tableName);

    return rows.map((row) => Restaurant.fromMap(row)).toList();
  }

  Future<void> deleteRestaurant(String id) async {
    final Database db = await database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<Restaurant> getRestaurantById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query(_tableName, where: 'id = ?', whereArgs: [id]);

    return results.map((res) => Restaurant.fromMap(res)).first;
  }
}
