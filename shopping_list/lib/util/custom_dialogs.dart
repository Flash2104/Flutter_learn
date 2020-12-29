import 'package:flutter/material.dart';
import 'package:shopping_list/models/db/product_item.dart';
import 'package:shopping_list/models/db/product_list.dart';
import 'package:shopping_list/util/db_helper.dart';

typedef submitCallback = Future Function();

class ItemDialog {
  final DbHelper _dbHelper;
  final submitCallback _submitFunc;

  ItemDialog(this._dbHelper, this._submitFunc);

  Future showAddDialog(BuildContext context, int listId) async {
    var item = DbProductItem(0, listId, '', '', '');
    await this._showAddOrEditDialog(context, item, isNew: true);
  }

  Future showEditDialog(BuildContext context, DbProductItem item) async {
    await this._showAddOrEditDialog(context, item);
  }

  Future _showAddOrEditDialog(BuildContext context, DbProductItem item, {bool isNew: false}) async {
    var title = isNew ? 'Добавить' : 'Редактировать';
    var nameController = TextEditingController(text: item.name);
    var noteController = TextEditingController(text: item.note);
    var quantityController = TextEditingController(text: item.quantity);
    await showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: SingleChildScrollView(
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
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: quantityController,
                  decoration: InputDecoration(labelText: 'Количество', hintText: 'Например: 2 кг. или 3 шт.'),
                ),
              )
            ],
          ),
        ])),
        actions: [
          RaisedButton(
            child: Text('Отмена'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            onPressed: () => Navigator.pop(context),
          ),
          RaisedButton(
            child: Text(title),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            onPressed: () {
              item.name = nameController.value.text;
              item.note = noteController.value.text;
              item.quantity = quantityController.value.text;
              _dbHelper.insertItem(item);
              _submitFunc();
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}

class ListDialog {
  final DbHelper _dbHelper;
  final submitCallback _submitFunc;

  ListDialog(this._dbHelper, this._submitFunc);

  Future showAddDialog(BuildContext context) async {
    await this._showAddOrEditDialog(context, null, isNew: true);
  }

  Future showEditDialog(BuildContext context, DbProductList list) async {
    await this._showAddOrEditDialog(context, list);
  }

  Future _showAddOrEditDialog(BuildContext context, DbProductList list, {bool isNew: false}) async {
    var title = isNew ? 'Добавить' : 'Редактировать';
    var nameController = TextEditingController(text: list.name);
    var priorityController = TextEditingController(text: list.priority.toString());
    await showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: SingleChildScrollView(
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
                      controller: priorityController,
                      keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                      decoration: InputDecoration(labelText: 'Приоритет', hintText: 'Чем меньше, тем выше список'),
                    ),
                  )
                ],
              ),
            ])),
        actions: [
          RaisedButton(
            child: Text('Отмена'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () => Navigator.pop(context),
          ),
          RaisedButton(
            child: Text(title),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () {
              list.name = nameController.value.text;
              list.priority = int.tryParse(priorityController.value.text) ?? 1;
              _dbHelper.insertList(list);
              _submitFunc();
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
