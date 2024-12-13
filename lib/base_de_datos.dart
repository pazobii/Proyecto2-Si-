import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart' show rootBundle;
  
class BaseDeDatos
{
  static Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'meow_coffee0.db'),
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE user(id VARCHAR NOT NULL, PRIMARY KEY(id))');
        await db.execute('CREATE TABLE recipe(name VARCHAR NOT NULL, category VARCHAR NOT NULL, preparation VARCHAR, ingredients TEXT, imageRoute VARCHAR, PRIMARY KEY(name));');
      },
      version: 1,
    );
  }
  
  static Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await database();
    await db.insert('user', user,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
    static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database();
    final List<Map<String, dynamic>> maps = await db.query('user');
    return maps;
  }

  static Future<void> updateUser(Map<String, dynamic> user) async {
    final db = await database();
    await db.update('user', user, where: 'id = ?', whereArgs: [user['id']]);
  }

  static Future<void> deleteUser(String id) async {
    final db = await database(); 
    await db.delete('user', where: 'id = ?', whereArgs: [id]);
  }

  
  static Future<void> insertRecipe(Map<String, dynamic> recipe) async {
    final db = await database();
    await db.insert('recipe', recipe,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
  
  static Future<List<Map<String, dynamic>>> getRecipes() async {
    final db = await database();
    final List<Map<String, dynamic>> maps = await db.query('Recipe');
    return maps;
  }

  static Future<void> updateRecipe(Map<String, dynamic> recipe) async {
    final db = await database();
    await db.update('recipe', recipe, where: 'name = ?', whereArgs: [recipe['name']]);
  }

  static Future<void> deleteRecipe(String name) async {
    final db = await database(); 
    await db.delete('recipe', where: 'name = ?', whereArgs: [name]);
  }
}