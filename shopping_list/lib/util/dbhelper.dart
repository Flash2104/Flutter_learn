import 'package:path/path.dart';
import 'package:shopping_list/models/db/product_item.dart';
import 'package:shopping_list/models/db/product_list.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  final int _version = 1;
  final String _dbName;
  final String _listsTableName = 'product_lists';
  final String _itemsTableName = 'product_items';
  Database _database;

  DbHelper(this._dbName);

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

  Future<int> insertList(DbProductList list) async {
    return await _database.insert(_listsTableName, list.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> insertItem(DbProductItem item) async {
    return await _database.insert(_itemsTableName, item.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future test() async {
    _database = await openDb();
    await _database.execute('INSERT INTO $_listsTableName VALUES (NULL, "Fruit", 2)');
    await _database.execute('INSERT INTO $_itemsTableName VALUES (NULL, 0, "Apples", "2 kg", "Green is better")');
    List lists = await _database.query('product_lists');
    List items = await _database.query('product_items');
    print('Lists 0: ${lists[0].toString()}');
    print('Items 0: ${items[0].toString()}');
  }

  Future removeDb() async {
    await deleteDatabase(join(await getDatabasesPath(), _dbName));
  }
}
