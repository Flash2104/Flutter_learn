import 'package:flutter/material.dart';
import 'package:shopping_list/util/dbhelper.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dbHelper = new DbHelper('shopping.db');
    dbHelper.removeDb();
    dbHelper.test();
    return MaterialApp(
      title: 'Список покупок',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Container(),
    );
  }
}


