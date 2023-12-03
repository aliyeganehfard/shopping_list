import 'dart:ui';

import 'package:shopping_list/models/category.dart';

final categories = {
  CategoriesType.vegetables: Category(
    'Vegetables',
    const Color.fromARGB(255, 0, 149, 255),
  ),
  CategoriesType.fruit: Category(
    'Fruit',
    const Color.fromARGB(255, 0, 255, 128),
  ),
  CategoriesType.dairy: Category(
    'Dairy',
    const Color.fromARGB(255, 255, 98, 0),
  ),
  CategoriesType.meat: Category(
    'Meat',
    const Color.fromARGB(255, 230, 0, 255),
  ),
  CategoriesType.carbs: Category(
    'Carbs',
    const Color.fromARGB(255, 0, 247, 255),
  ),
  CategoriesType.sweets: Category(
    'Sweets',
    const Color.fromARGB(255, 255, 153, 0),
  ),
  CategoriesType.spices: Category(
    'Spices',
    const Color.fromARGB(255, 0, 89, 255),
  ),
  CategoriesType.convenience: Category(
    'Convenience',
    const Color.fromARGB(255, 161, 0, 255),
  ),
  CategoriesType.hygiene: Category(
    'Hygiene',
    const Color.fromARGB(255, 0, 255, 217),
  ),
  CategoriesType.other: Category(
    'Other',
    const Color.fromARGB(169, 255, 106, 0),
  ),
};
