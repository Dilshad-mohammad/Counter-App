import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/user.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        username TEXT PRIMARY KEY,
        count INTEGER NOT NULL
      )
    ''');
  }

  Future<User?> getUser(String username) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    return result.isNotEmpty ? User.fromMap(result.first) : null;
  }

  Future<int> insertUser(User user) async {
    final db = await instance.database;
    return await db.insert('users', user.toMap());
  }

  Future<int> updateCount(String username, int newCount) async {
    final db = await instance.database;
    return await db.update(
      'users',
      {'count': newCount},
      where: 'username = ?',
      whereArgs: [username],
    );
  }
}