import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';

class Database {
  static final Database _instance = Database._internal();
  factory Database() => _instance;
  Database._internal();

  sqflite.Database? _db;

  /// Gets the database instance, initializing it if necessary.
  Future<sqflite.Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<sqflite.Database> _initDatabase() async {
    final databasePath = await sqflite.getDatabasesPath();
    final path = join(databasePath, 'julio_app.db');

    return await sqflite.openDatabase(
      path,
      version: 1, // Increment this when changing the schema
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  /// Initial database creation
  Future<void> _onCreate(sqflite.Database db, int version) async {
    // Version 1 Schema
    await db.execute('''
      CREATE TABLE lancamento (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        data INTEGER NOT NULL,
        ciclo INTEGER NOT NULL,
        valor INTEGER NOT NULL,
        placa TEXT CHECK(length(placa) <= 20)
      )
    ''');
  }

  /// Handles schema updates across different versions
  Future<void> _onUpgrade(sqflite.Database db, int oldVersion, int newVersion) async {
    for (int i = oldVersion + 1; i <= newVersion; i++) {
      await _runMigration(db, i);
    }
  }

  /// Run specific migration logic for a given version
  Future<void> _runMigration(sqflite.Database db, int version) async {
    switch (version) {
      // Example migration for version 2:
      // case 2:
      //   await db.execute('ALTER TABLE lancamento ADD COLUMN observacao TEXT');
      //   break;
    }
  }

  // --- Specialized CRUD Operations ---

  /// Gets a single record by its ID.
  Future<Map<String, dynamic>?> get(String table, int id) async {
    final client = await db;
    final maps = await client.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  /// Deletes a single record by its ID.
  Future<int> delete(String table, int id) async {
    final client = await db;
    return await client.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // --- Generic CRUD Operations ---

  /// Inserts a map of data into the specified table, always generating a new ID.
  Future<int> insert(String table, Map<String, dynamic> data) async {
    final client = await db;

    // Criamos uma cópia e removemos o ID para garantir que o banco gere um novo via AUTOINCREMENT
    final Map<String, dynamic> map = Map.from(data);
    map.remove('id');

    return await client.insert(table, map);
  }

  /// Queries data from the specified table.
  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final client = await db;
    return await client.query(
      table,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  /// Updates existing records in the specified table.
  Future<int> update(
    String table,
    Map<String, dynamic> data, {
    required String where,
    required List<dynamic> whereArgs,
  }) async {
    final client = await db;
    return await client.update(
      table,
      data,
      where: where,
      whereArgs: whereArgs,
    );
  }

  /// Executes a raw SQL command.
  Future<void> execute(String sql, [List<Object?>? arguments]) async {
    final client = await db;
    await client.execute(sql, arguments);
  }
}
