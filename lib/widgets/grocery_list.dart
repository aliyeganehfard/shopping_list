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

  // var _isLoading = true;
  String? _error = null;
  late Future<List<GroceryItem>> _loadedItems;

  @override
  void initState() {
    super.initState();
    _loadedItems = _loadItems();
  }

  Future<List<GroceryItem>> _loadItems() async {
    // try {
    final url = Uri.https(
        'flutter-prep-f44cd-default-rtdb.firebaseio.com', 'shopping_list.json');
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      throw Exception('Failed to fetch data. Please try again later');
      // setState(() {
      //   _error = 'Failed to fetch data. Please try again later';
      // });
      // return [];
    }

    if (response.body == 'null') {
      // setState(() {
      //   _isLoading = false;
      // });
      return [];
    }

    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> loadedItem = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
              (certItem) => certItem.value.title == item.value['category'])
          .value;
      final grocery = GroceryItem(
        id: item.key,
        title: item.value['title'],
        quantity: item.value['quantity'],
        category: category,
      );
      loadedItem.add(grocery);
    }
    // setState(() {
    //   _groceryItems = loadedItem;
    //   _isLoading = false;
    // });
    return loadedItem;
    // } catch (error) {
    //   setState(() {
    //     _error = 'Something went wrong! Please try again later';
    //   });
    // }
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void removeItem(GroceryItem item) async {
    final _index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });

    final url = Uri.https(
      'flutter-prep-f44cd-default-rtdb.firebaseio.com',
      'shopping_list/${item.id}.json',
    );

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(_index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Widget content = const Center(
    //   child: Text('No items added yet.'),
    // );
    //
    // if (_groceryItems.isNotEmpty) {
    //   content = ListView.builder(
    //     itemCount: _groceryItems.length,
    //     itemBuilder: (ctx, index) => Dismissible(
    //       onDismissed: (direction) {
    //         removeItem(_groceryItems[index]);
    //       },
    //       key: ValueKey(_groceryItems[index].id),
    //       child: ListTile(
    //         title: Text(_groceryItems[index].title),
    //         leading: Container(
    //           width: 24,
    //           height: 24,
    //           color: _groceryItems[index].category.color,
    //         ),
    //         trailing: Text(_groceryItems[index].quantity.toString()),
    //       ),
    //     ),
    //   );
    // }
    //

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
      body: FutureBuilder(
          future: _loadedItems,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('No items added yet.'));
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) => Dismissible(
                onDismissed: (direction) {
                  removeItem(snapshot.data![index]);
                },
                key: ValueKey(snapshot.data![index].id),
                child: ListTile(
                  title: Text(snapshot.data![index].title),
                  leading: Container(
                    width: 24,
                    height: 24,
                    color: snapshot.data![index].category.color,
                  ),
                  trailing: Text(snapshot.data![index].quantity.toString()),
                ),
              ),
            );
          }),
    );
  }
}
