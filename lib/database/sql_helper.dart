import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  // Create the tables for employee and food
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE employee(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        email TEXT
      );
    """);

    await database.execute("""
      CREATE TABLE food(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        ingredients TEXT
      );
    """);
  }

  // Initialize the database
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'employee_food.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // CRUD Operations for Employee
  // Insert employee
  static Future<int> addEmployee(String name, String email) async {
    final db = await SQLHelper.db();
    final data = {'name': name, 'email': email};
    return await db.insert('employee', data);
  }

  // Get all employees
  static Future<List<Map<String, dynamic>>> getEmployee() async {
    final db = await SQLHelper.db();
    return db.query('employee');
  }

  // Update employee
  static Future<int> editEmployee(int id, String name, String email) async {
    final db = await SQLHelper.db();
    final data = {'name': name, 'email': email};
    return await db.update('employee', data, where: "id = ?", whereArgs: [id]);
  }

  // Delete employee
  static Future<int> deleteEmployee(int id) async {
    final db = await SQLHelper.db();
    return await db.delete('employee', where: "id = ?", whereArgs: [id]);
  }

  // CRUD Operations for Food
  // Insert food item
  static Future<int> addFood(String name, String ingredients) async {
    final db = await SQLHelper.db();
    final data = {'name': name, 'ingredients': ingredients};
    return await db.insert('food', data);
  }

  // Get all food items
  static Future<List<Map<String, dynamic>>> getFood() async {
    final db = await SQLHelper.db();
    return db.query('food');
  }

  // Update food item
  static Future<int> editFood(int id, String name, String ingredients) async {
    final db = await SQLHelper.db();
    final data = {'name': name, 'ingredients': ingredients};
    return await db.update('food', data, where: "id = ?", whereArgs: [id]);
  }

  // Delete food item
  static Future<int> deleteFood(int id) async {
    final db = await SQLHelper.db();
    return await db.delete('food', where: "id = ?", whereArgs: [id]);
  }
}
