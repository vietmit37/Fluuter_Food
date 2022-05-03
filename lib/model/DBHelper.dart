import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:project_food/model/Category.dart';
import 'package:sqflite/sqflite.dart';

import 'Recipe.dart';

class DBHelper {
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
          image: item['image'], time: item['time']
      ));
    }
    db.close();
    return data;
  }

  likeRecipe(int recipeID, int likedState) async {
    Database db = await openDB();
    int setStatus = likedState == 1 ? 0 : 1;
    await db.rawQuery("UPDATE Recipes SET liked = $setStatus WHERE id = $recipeID");
    // var list = await db.query('Recipes', limit: limit);
    db.close();
  }

  Future<List<Recipe>> getRecipesByCate(String categoryName) async {
    List<Recipe> data = new List<Recipe>();
    Database db = await openDB();
    var list = await db.rawQuery("SELECT * FROM Recipes WHERE categoryName = '$categoryName'");
    // var list = await db.query('Recipes', limit: limit);
    for (var item in list.toList()){
      data.add(Recipe(
          id: item['id'], name: item['name'],
          ingredients: item['ingredients'], time: item['time'],
          preparation: item['preparation'], liked: item['liked'],
          image: item['image'], categoryName: item['categoryName']
      ));
    }
    db.close();
    return data;
  }

  Future<List<Category>> getCategoryList() async {
    List<Category> data = new List<Category>();
    Database db = await openDB();
    // var list = await db.rawQuery('SELECT name FROM Categories');
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
    // var list = await db.query('Recipes', limit: limit);
    for (var item in list.toList()){
      data.add(Recipe(
          id: item['id'], name: item['name'],
          ingredients: item['ingredients'], time: item['time'],
          preparation: item['preparation'], liked: item['liked'],
          image: item['image'], categoryName: item['categoryName']
      ));
    }
    db.close();
    return data;
  }
}