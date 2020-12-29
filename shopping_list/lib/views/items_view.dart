import 'package:flutter/material.dart';
import 'package:shopping_list/models/db/product_item.dart';
import 'package:shopping_list/models/db/product_list.dart';
import 'package:shopping_list/util/db_helper.dart';
import 'package:shopping_list/util/custom_dialogs.dart';

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
  ItemDialog _dialog;

  _ItemsViewState(this._dbHelper, this._list);

  @override
  void initState() {
    this._fillItems();
    _dialog = ItemDialog(_dbHelper, this._fillItems);
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
                      _dialog.showAddDialog(context, _list.id);
                    },
                  ),
                );
              }
              var item = _items[index];
              return ListTile(
                onTap: () {
                  _dialog.showEditDialog(context, item);
                },
                title: Text(item.name),
                subtitle: Column(
                  children: [
                    item.note != ''
                        ? Row(
                            children: [Expanded(child: Text('Заметка: ${item.note}'))],
                          )
                        : Row(),
                    item.quantity != ''
                        ? Row(
                            children: [
                              Expanded(
                                  child: Text(
                                'Количество: ${item.quantity}',
                                style: TextStyle(color: Colors.blue[300]),
                              ))
                            ],
                          )
                        : Row()
                  ],
                ),
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
}
