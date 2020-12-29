import 'package:flutter/material.dart';
import 'package:shopping_list/models/db/product_item.dart';
import 'package:shopping_list/models/db/product_list.dart';
import 'package:shopping_list/util/db_helper.dart';

class ItemsView extends StatefulWidget {
  final DbProductList _list;
  final DbHelper _dbHelper;

  ItemsView(this._dbHelper, this._list);

  @override
  _ItemsViewState createState() => _ItemsViewState(_dbHelper, _list);
}

class _ItemsViewState extends State<ItemsView> {
  final DbProductList _list;
  final DbHelper _dbHelper;
  List<DbProductItem> _items;

  _ItemsViewState(this._dbHelper, this._list);

  @override
  void initState() {
    this._fillItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_list?.name ?? ''),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: (_items != null) ? _items.length + 1 : 1,
            itemBuilder: (context, index) {
              if (_items == null || index >= _items?.length) {
                return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    title: Icon(Icons.add_outlined),
                    onTap: () {
                      _editItem(null);
                    },
                  ),
                );
              }
              var item = _items[index];
              return ListTile(
                onTap: () {
                  _editItem(item);
                },
                title: Text(item.name),
                subtitle: Text(item.note),
                trailing: IconButton(
                  onPressed: () {
                    _deleteItem(item.id);
                  },
                  icon: Icon(Icons.delete),
                ),
              );
            },
          ),
        ));
  }

  Future _fillItems() async {
    var items = await _dbHelper.getItemsByList(_list.id);
    setState(() {
      _items = items;
    });
  }

  Future _deleteItem(int id) async {
    await _dbHelper.deleteItem(id);
    await _fillItems();
  }

  Future _editItem(DbProductItem item) async {
    var title = 'Редактировать';
    if (item == null) {
      title = 'Добавить';
      item = DbProductItem(0, _list.id, '', '1', '');
    }
    var nameController = TextEditingController(text: item.name);
    var noteController = TextEditingController(text: item.note);
    var answer = await showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) =>  AlertDialog(
        content: Container(
            padding: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height*0.35,
            child: Column(children: [
              Row(children: [
                Expanded(
                  child: TextField(
                    autofocus: true,
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Название'),
                  ),
                )
              ]),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: noteController,
                      decoration: InputDecoration(labelText: 'Заметка'),
                    ),
                  )
                ],
              ),
            ])),
        actions: [
          MaterialButton(
            child: Text('Отмена'),
            onPressed: () => Navigator.pop(context),
          ),
          MaterialButton(
            child: Text(title),
            onPressed: () {
              item.name = nameController.value.text;
              item.note = noteController.value.text;
              _dbHelper.insertItem(item);
              _fillItems();
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
