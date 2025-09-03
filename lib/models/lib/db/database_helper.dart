import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/patient_log.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'intern_logbook.db');

    return await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE logs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          age INTEGER,
          department TEXT,
          notes TEXT,
          date TEXT
        )
      ''');
    });
  }

  Future<int> insertLog(PatientLog log) async {
    final database = await db;
    return await database.insert('logs', log.toMap());
  }

  Future<List<PatientLog>> getLogs() async {
    final database = await db;
    final res = await database.query('logs', orderBy: 'date DESC');
    return res.map((m) => PatientLog.fromMap(m)).toList();
  }

  Future<int> updateLog(PatientLog log) async {
    final database = await db;
    return await database.update('logs', log.toMap(), where: 'id = ?', whereArgs: [log.id]);
  }

  Future<int> deleteLog(int id) async {
    final database = await db;
    return await database.delete('logs', where: 'id = ?', whereArgs: [id]);
  }
}
