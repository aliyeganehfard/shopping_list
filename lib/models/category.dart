import 'package:flutter/material.dart' show Color;

enum CategoriesType {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other,
}

class Category {
  Category(this.title, this.color);

  final String title;
  final Color color;
}
