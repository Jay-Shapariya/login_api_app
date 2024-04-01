import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await createDatabase();
    return _database!;
  }

  Future<Database> createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String usersDatabasePath = join(databasesPath, 'users.db');

    return await openDatabase(
      usersDatabasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, userid TEXT, password TEXT)',
        );
      },
    );
  }

  Future<void> insertUser(String userid, String password) async {
    final db = await database;
    await db.insert(
      'users',
      {'userid': userid, 'password': password},
      conflictAlgorithm:
          ConflictAlgorithm.replace, // Optionally replace existing
    );
  }
}
