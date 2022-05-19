import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:project_food/model/Category.dart';
import 'package:project_food/model/History.dart';
import 'package:sqflite/sqflite.dart';

import 'Recipe.dart';

class DBHelper {
  final timeFormat = new DateFormat('HH:mm, dd/MM/yyyy');

  copyDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "MonAnDB.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data = await rootBundle.load(join("assets", "MonAnDB.db"));
      List<int> bytes = data.buffer.asUint8List(
          data.offsetInBytes, data.lengthInBytes);

      await new File(path).writeAsBytes(bytes);
    }
  }

  openDB() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'MonAnDB.db');
    return await openDatabase(databasePath);
  }

  Future<List<Recipe>> getRecipeList(int limit) async {
    List<Recipe> data = new List<Recipe>();
    Database db = await openDB();

    // var list = await db.rawQuery('SELECT * FROM Students');
    var list = await db.query('Recipes', limit: limit);
    for (var item in list.toList()){
      data.add(Recipe(
          id: item['id'], name: item['name'],
          categoryName: item['categoryName'], ingredients: item['ingredients'],
          preparation: item['preparation'], liked: item['liked'],
          image: item['image'], time: item['time'], videoURL: item['videoURL']
      ));
    }

    db.close();
    return data;
  }

  Future<Recipe> getRecipeById(int id) async {
    List<Recipe> data = new List<Recipe>();
    Database db = await openDB();

    var result = await db.rawQuery('SELECT * FROM Recipes WHERE id = $id');
    for (var item in result.toList()){
      data.add(Recipe(
          id: item['id'], name: item['name'],
          categoryName: item['categoryName'], ingredients: item['ingredients'],
          preparation: item['preparation'], liked: item['liked'],
          image: item['image'], time: item['time'], videoURL: item['videoURL']
      ));
    }

    db.close();
    return data[0];
  }

  Future<int> likeRecipe(int recipeID, int likedState) async {
    Database db = await openDB();
    int setStatus = likedState == 1 ? 0 : 1;
    await db.rawQuery("UPDATE Recipes SET liked = $setStatus WHERE id = $recipeID");
    // var list = await db.query('Recipes', limit: limit);
    db.close();
    return 1;
  }

  Future<List<Recipe>> getRecipesByCate(String categoryName) async {
    List<Recipe> data = new List<Recipe>();
    Database db = await openDB();

    var list = await db.rawQuery("SELECT * FROM Recipes WHERE categoryName = '$categoryName'");
    for (var item in list.toList()){
      data.add(Recipe(
          id: item['id'], name: item['name'],
          ingredients: item['ingredients'], time: item['time'],
          preparation: item['preparation'], liked: item['liked'],
          image: item['image'], categoryName: item['categoryName'], videoURL: item['videoURL']
      ));
    }

    db.close();
    return data;
  }

  Future<List<Category>> getCategoryList() async {
    List<Category> data = new List<Category>();
    Database db = await openDB();

    var list = await db.query('Categories');
    for (var item in list.toList()){
      data.add(Category(
          name: item['name'], image: item['image']
      ));
    }

    db.close();
    return data;
  }

  Future<List<Recipe>> getLikedRecipes() async {
    List<Recipe> data = new List<Recipe>();
    Database db = await openDB();

    var list = await db.rawQuery("SELECT * FROM Recipes WHERE liked = 1");
    for (var item in list.toList()){
      data.add(Recipe(
          id: item['id'], name: item['name'],
          ingredients: item['ingredients'], time: item['time'],
          preparation: item['preparation'], liked: item['liked'],
          image: item['image'], categoryName: item['categoryName'], videoURL: item['videoURL']
      ));
    }

    db.close();
    return data;
  }

  Future<List<Recipe>> searchRecipes(String searchKeyword) async {
    List<Recipe> data = new List<Recipe>();
    Database db = await openDB();

    var list = await db.rawQuery("SELECT * FROM Recipes WHERE name LIKE '%$searchKeyword%';");
    for (var item in list.toList()){
      data.add(Recipe(
          id: item['id'], name: item['name'],
          ingredients: item['ingredients'], time: item['time'],
          preparation: item['preparation'], liked: item['liked'],
          image: item['image'], categoryName: item['categoryName'], videoURL: item['videoURL']
      ));
    }

    db.close();
    return data;
  }

  Future<List<History>> getHistory() async {
    List<History> data = new List<History>();
    Database db = await openDB();

    var list = await db.rawQuery("SELECT * FROM History ORDER BY id DESC");
    for (var item in list.toList()){
      bool recipeAlreadyExist = false;

      for (var history in data){
        if (history.recipeID == item['recipeID']){
          recipeAlreadyExist = true;
          break;
        }
      }

      if (!recipeAlreadyExist){
        data.add(History(
            id: item['id'], recipeID: item['recipeID'], time: item['time'],
            recipeName: item['recipeName']
        ));
      }
    }

    db.close();
    return data;
  }

  Future<int> addToHistory(Recipe recipe) async {
    Database db = await openDB();

    Map<String, String> values = {
      'recipeID': recipe.id.toString(),
      'recipeName': recipe.name,
      'time': timeFormat.format(DateTime.now()).toString()
    };
    var result = db.insert('History', values);

    db.close();
    return result;
  }

  Future<int> deleteHistory() async {
    Database db = await openDB();

    var result = db.delete('History');
    db.close();

    return result;
  }
}