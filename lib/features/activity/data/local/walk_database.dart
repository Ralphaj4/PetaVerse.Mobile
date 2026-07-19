import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

/// Multi-row SQLite store for walks awaiting upload.
///
/// Each walk is its own row. Status lifecycle:
///   'active'       — walk in progress (at most one at a time)
///   'pending_sync' — stopped, waiting for a successful API upload
/// Rows are deleted once synced; the table only ever holds unsynced work.
class WalkDatabase {
  WalkDatabase._();
  static final WalkDatabase instance = WalkDatabase._();

  static const _dbName = 'walk_session.db';
  static const _table = 'active_walk';

  Database? _db;

  Future<Database> get _database async {
    _db ??= await _open();
    return _db!;
  }

  Future<Database> _open() async {
    final dbPath = p.join(await getDatabasesPath(), _dbName);
    return openDatabase(
      dbPath,
      version: 2,
      onCreate: (db, _) => db.execute('''
        CREATE TABLE $_table (
          id          INTEGER PRIMARY KEY,
          pet_id      INTEGER NOT NULL,
          pet_name    TEXT    NOT NULL DEFAULT '',
          started_at  TEXT    NOT NULL,
          ended_at    TEXT,
          duration_s  INTEGER,
          distance_m  REAL,
          avg_speed   REAL,
          has_location INTEGER NOT NULL DEFAULT 0,
          status      TEXT    NOT NULL DEFAULT 'active'
        )
      '''),
      onUpgrade: (db, oldVersion, _) async {
        if (oldVersion < 2) {
          await db.execute(
            "ALTER TABLE $_table ADD COLUMN pet_name TEXT NOT NULL DEFAULT ''",
          );
        }
      },
    );
  }

  /// Inserts a new active-walk row and returns its id.
  Future<int> insertActive({
    required int petId,
    required String petName,
    required DateTime startedAt,
    required bool hasLocation,
  }) async {
    final db = await _database;
    return db.insert(_table, {
      'pet_id': petId,
      'pet_name': petName,
      'started_at': startedAt.toUtc().toIso8601String(),
      'has_location': hasLocation ? 1 : 0,
      'status': 'active',
    });
  }

  /// Persists live progress every tick so a killed app resumes with the
  /// latest distance/speed instead of zeros.
  Future<void> updateProgress({
    required int id,
    required int durationSeconds,
    double? distanceMeters,
    double? avgSpeedKmh,
  }) async {
    final db = await _database;
    await db.update(
      _table,
      {
        'duration_s': durationSeconds,
        'distance_m': distanceMeters,
        'avg_speed': avgSpeedKmh,
      },
      where: "id = ? AND status = 'active'",
      whereArgs: [id],
    );
  }

  /// Marks the walk as stopped with final stats, ready for sync.
  Future<void> markStopped({
    required int id,
    required DateTime endedAt,
    required int durationSeconds,
    double? distanceMeters,
    double? avgSpeedKmh,
  }) async {
    final db = await _database;
    await db.update(
      _table,
      {
        'ended_at': endedAt.toUtc().toIso8601String(),
        'duration_s': durationSeconds,
        'distance_m': distanceMeters,
        'avg_speed': avgSpeedKmh,
        'status': 'pending_sync',
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// The in-progress walk, if any (most recent wins).
  Future<Map<String, dynamic>?> getActive() async {
    final db = await _database;
    final rows = await db.query(
      _table,
      where: "status = 'active'",
      orderBy: 'id DESC',
      limit: 1,
    );
    return rows.isEmpty ? null : rows.first;
  }

  /// All stopped walks still waiting for a successful upload, oldest first.
  Future<List<Map<String, dynamic>>> getPendingSync() async {
    final db = await _database;
    return db.query(
      _table,
      where: "status = 'pending_sync'",
      orderBy: 'id ASC',
    );
  }

  /// Removes a row after it has been synced.
  Future<void> deleteWalk(int id) async {
    final db = await _database;
    await db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    await _db?.close();
    _db = null;
  }
}
