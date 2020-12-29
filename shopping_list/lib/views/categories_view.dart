import 'package:flutter/material.dart';
import 'package:shopping_list/models/db/product_list.dart';
import 'package:shopping_list/util/custom_dialogs.dart';
import 'package:shopping_list/util/db_helper.dart';
import 'package:shopping_list/views/items_view.dart';

class CategoriesView extends StatefulWidget {
  final DbHelper _dbHelper;

  CategoriesView(this._dbHelper);

  @override
  _CategoriesViewState createState() => _CategoriesViewState(this._dbHelper);
}

class _CategoriesViewState extends State<CategoriesView> {
  final DbHelper _dbHelper;
  List<DbProductList> _lists = List();

  ListDialog _dialog;

  _CategoriesViewState(this._dbHelper);

  @override
  void initState() {
    this._init();
    _dialog = ListDialog(_dbHelper, this._fillLists);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: (_lists != null) ? _lists.length + 1 : 1,
        itemBuilder: (context, index) {
          if (index >= _lists.length) {
            return RaisedButton(
              child: Icon(Icons.add_outlined),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              onPressed: () => _dialog.showAddDialog(context),
            );
          }
          var list = _lists[index];
          return Dismissible(
              key: Key(list.name),
              onDismissed: (direction) {
                _dbHelper.deleteList(list.id);
                setState(() {
                  _lists.removeAt(index);
                });
                Scaffold.of(context).showSnackBar(SnackBar(content: Text('Категория \"${list.name}\" удалена!'), duration: Duration(seconds: 1)));
              },
              child: ListTile(
                onTap: () {
                  var route = MaterialPageRoute(builder: (ctx) => ItemsView(_dbHelper, list));
                  Navigator.push(context, route);
                },
                title: Text(list.name),
                leading: CircleAvatar(
                  child: Text(list.priority.toString()),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _dialog.showEditDialog(context, list);
                  },
                ),
              ));
        },
      ),
    );
  }

  Future _init() async {
    var created = await _dbHelper.test();
    if (!created) {
      DbProductList list1 = DbProductList(0, 'Мучное', 4);
      DbProductList list7 = DbProductList(0, 'Молочное', 3);
      DbProductList list2 = DbProductList(0, 'Овощи, фрукты', 1);
      DbProductList list3 = DbProductList(0, 'Мясное', 3);
      DbProductList list4 = DbProductList(0, 'Напитки', 2);
      DbProductList list5 = DbProductList(0, 'Бытовые', 5);
      DbProductList list6 = DbProductList(0, 'Другое', 5);
      int listId1 = await _dbHelper.insertList(list1);
      int listId2 = await _dbHelper.insertList(list2);
      int listId3 = await _dbHelper.insertList(list3);
      int listId4 = await _dbHelper.insertList(list4);
      int listId5 = await _dbHelper.insertList(list5);
      int listId6 = await _dbHelper.insertList(list6);
      int listId7 = await _dbHelper.insertList(list7);
    }
    await _fillLists();
  }

  Future _fillLists() async {
    var list = await _dbHelper.getLists();
    setState(() {
      _lists = list;
    });
  }
}
