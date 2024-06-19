import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'employees';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'employee_database.db'),
      version: 2, // Incremented database version
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, gender TEXT, email TEXT, mobile TEXT, attendanceDate TEXT)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE $tableName ADD COLUMN attendanceDate TEXT');
        }
      },
    );
  }

  Future<void> insertEmployee(Map<String, dynamic> employee) async {
    final db = await database;
    await db.insert(
      tableName,
      employee,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getEmployees(String employeeDetail) async {
    final db = await database;
    return db.query(tableName);
  }

  Future<Map<String, dynamic>?> getEmployeeById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<void> updateEmployee(Map<String, dynamic> employee) async {
    final db = await database;
    await db.update(
      tableName,
      employee,
      where: 'id = ?',
      whereArgs: [employee['id']],
    );
  }

  Future<void> deleteEmployee(int id) async {
    final db = await database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> saveEmployee(Map<String, dynamic> employee) async {
    await insertEmployee(employee);
  }

  Future<Map<String, dynamic>?> getEmployeeByCriteria(String criteria) async {
    final db = await database;
    final results = await db.query(
      tableName,
      where: 'id = ? OR name LIKE ? OR gender = ? OR email = ? OR mobile = ?',
      whereArgs: [criteria, '%$criteria%', criteria, criteria, criteria],
    );
    return results.isNotEmpty ? results.first : null;
  }
  Future<List<Map<String, dynamic>>> getEmployeesByDateRange(String fromDate, String toDate) async {
  final db = await database;
  return await db.query(
    tableName,
    where: 'attendanceDate BETWEEN ? AND ?',
    whereArgs: [fromDate, toDate],
  );
}
}
