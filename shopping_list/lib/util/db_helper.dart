import 'package:path/path.dart';
import 'package:shopping_list/main.dart';
import 'package:shopping_list/models/db/product_item.dart';
import 'package:shopping_list/models/db/product_list.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  final int _version = 1;
  String _dbName;
  final String _listsTableName = 'product_lists';
  final String _itemsTableName = 'product_items';
  Database _database;

  static final DbHelper _shoppingDbHelper = DbHelper._shoppingList();

  DbHelper._shoppingList() {
    this._dbName = shoppingListDbName;
  }

  factory DbHelper(dbName) {
    switch (dbName) {
      case shoppingListDbName:
        {
          return _shoppingDbHelper;
        }
      default:
        {
          return _shoppingDbHelper;
        }
    }
  }

  Future<Database> openDb() async {
    if (_database == null) {
      var dbPath = join(await getDatabasesPath(), _dbName);
      _database = await openDatabase(dbPath, onCreate: (db, version) async {
        await db.execute('CREATE TABLE $_listsTableName(id INTEGER PRIMARY KEY, name TEXT, priority INTEGER)');
        await db.execute('CREATE TABLE $_itemsTableName('
            'id INTEGER PRIMARY KEY, '
            'productLists INTEGER, '
            'name TEXT, '
            'quantity TEXT, '
            'note TEXT, '
            'FOREIGN KEY(productLists) REFERENCES product_lists(id))');
      }, version: _version);
    }
    return _database;
  }

  Future<List<DbProductList>> getLists() async {
    _database = await openDb();
    List<Map<String, dynamic>> maps = await _database.query(_listsTableName);
    List<DbProductList> lists = maps.map((e) => DbProductList.fromMap(e)).toList();
    lists.sort((a, b) => a.priority.compareTo(b.priority));
    return lists ?? List();
  }

  Future<List<DbProductItem>> getItemsByList(int listId) async {
    _database = await openDb();
    List<Map<String, dynamic>> maps = await _database.query(_itemsTableName, where: 'productLists = ?', whereArgs: [listId]);
    List<DbProductItem> items = maps.map((e) => DbProductItem.fromMap(e)).toList();
    return items ?? List();
  }

  Future<int> insertList(DbProductList list) async {
    return await _database.insert(_listsTableName, list.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> insertItem(DbProductItem item) async {
    return await _database.insert(_itemsTableName, item.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future deleteItem(int id) async {
    _database = await openDb();
    await _database.delete(_itemsTableName, where: 'id = ?', whereArgs: [id]);
  }

  Future deleteList(int id) async {
    _database = await openDb();
    await _database.delete(_itemsTableName, where: 'productLists = ?', whereArgs: [id]);
    // await _database.delete(_listsTableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> test() async {
    _database = await openDb();
    List lists = await _database.query(_listsTableName);
    return lists.length > 0;
  }

  Future removeDb() async {
    await deleteDatabase(join(await getDatabasesPath(), _dbName));
  }

  Future close() async {
    await _database.close();
  }
}
