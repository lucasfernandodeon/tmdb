import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TmdbDatabase {
  static const _databaseName = "tmdb_database.db";
  static const _databaseVersion = 1;

  Database? _databaseInstance;

  Future<Database> get database async {
    if (_databaseInstance != null) return _databaseInstance!;

    _databaseInstance = await _init();
    return _databaseInstance!;
  }

  Future<Database> _init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE movie_details_favorite (
            id INTEGER PRIMARY KEY NOT NULL,
            movie_id INTEGER NOT NULL,
            poster_path TEXT,
            overview TEXT,
             release_date TEXT NOT NULL,
              video INTEGER NOT NULL,
              vote_average REAL NOT NULL,
              runtime REAL
          )
          ''');
  }
}
