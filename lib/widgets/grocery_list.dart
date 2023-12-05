import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/dummy_categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
        'flutter-prep-f44cd-default-rtdb.firebaseio.com', 'shopping_list.json');
    final response = await http.get(url);
    final Map<String, dynamic> listData =
        json.decode(response.body);
    final List<GroceryItem> loadedItem = [];
    for (final item in listData.entries) {
      final category = categories.entries.firstWhere((certItem) => certItem.value.title == item.value['category']).value;
      final grocery = GroceryItem(
        id: item.key,
        title: item.value['title'],
        quantity: item.value['quantity'],
        category: category,
      );
      loadedItem.add(grocery);
    }
    setState(() {
      _groceryItems = loadedItem;
    });
  }

  void _addItem() async {
    /*final newItem =*/ await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
    // if (newItem == null) {
    //   return;
    // }
    //
    // setState(() {
    //   _groceryItems.add(newItem);
    // });
    _loadItems();
  }

  void removeItem(GroceryItem item) {
    setState(() {
      _groceryItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No items added yet.'),
    );

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            removeItem(_groceryItems[index]);
          },
          key: ValueKey(_groceryItems[index].id),
          child: ListTile(
            title: Text(_groceryItems[index].title),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(_groceryItems[index].quantity.toString()),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
