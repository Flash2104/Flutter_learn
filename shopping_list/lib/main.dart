import 'package:flutter/material.dart';
import 'package:shopping_list/models/db/product_item.dart';
import 'package:shopping_list/models/db/product_list.dart';
import 'package:shopping_list/util/db_helper.dart';
import 'package:shopping_list/views/categories_view.dart';

final String _shoppingListDbName = 'shopping.db';

void main() {
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  final DbHelper _dbHelper = DbHelper(_shoppingListDbName);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Список покупок',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Категории'),
        ),
        body: CategoriesView(_dbHelper),
      ),
    );
  }
}

