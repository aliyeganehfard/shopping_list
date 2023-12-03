import 'package:shopping_list/data/dummy_categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';

final groceryItems = [
  GroceryItem(
    id: 'a',
    title: 'Milk',
    quantity: 1,
    category: categories[CategoriesType.dairy]!,
  ),
  GroceryItem(
    id: 'b',
    title: 'Apples',
    quantity: 5,
    category: categories[CategoriesType.fruit]!,
  ),
  GroceryItem(
    id: 'c',
    title: 'Chicken',
    quantity: 2,
    category: categories[CategoriesType.meat]!,
  ),
  GroceryItem(
    id: 'd',
    title: 'Bread',
    quantity: 1,
    category: categories[CategoriesType.carbs]!,
  ),
  GroceryItem(
    id: 'e',
    title: 'Chocolate',
    quantity: 3,
    category: categories[CategoriesType.sweets]!,
  ),
  GroceryItem(
    id: 'f',
    title: 'Cumin',
    quantity: 1,
    category: categories[CategoriesType.spices]!,
  ),
  GroceryItem(
    id: 'g',
    title: 'Cereal',
    quantity: 1,
    category: categories[CategoriesType.convenience]!,
  ),
  GroceryItem(
    id: 'h',
    title: 'Shampoo',
    quantity: 1,
    category: categories[CategoriesType.hygiene]!,
  ),
  GroceryItem(
    id: 'i',
    title: 'Onions',
    quantity: 3,
    category: categories[CategoriesType.vegetables]!,
  ),
  GroceryItem(
    id: 'j',
    title: 'Pasta',
    quantity: 2,
    category: categories[CategoriesType.carbs]!,
  ),
  GroceryItem(
    id: 'k',
    title: 'Yogurt',
    quantity: 2,
    category: categories[CategoriesType.dairy]!,
  ),
  GroceryItem(
    id: 'l',
    title: 'bananas',
    quantity: 5,
    category: categories[CategoriesType.fruit]!,
  ),
];
