import 'dart:typed_data';

class Recipe {
  String name, ingredients, preparation, categoryName;
  int id, time;
  int liked;
  Uint8List image;

  Recipe({
    this.name,
    this.ingredients,
    this.preparation,
    this.id,
    this.categoryName,
    this.image,
    this.time,
    this.liked,
  });
}
