import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String DBNAME = 'mapp.db';
const String PLACES_TABLE = 'places';

class DbService {
  final int _version = 1;
  Database _db;
  static final DbService _dbService = DbService._();

  DbService._();

  factory DbService() {
    return _dbService;
  }

  Future<Database> _openDb() async {
    if (_db == null) {
      var dbPath = await getDatabasesPath();
      _db = await openDatabase(
        join(dbPath, DBNAME),
        onCreate: (db, version) {
          db.execute('CREATE TABLE ${PLACES_TABLE}(id INTEGER PRIMARY KEY, name TEXT, lat DOUBLE, lon DOUBLE, image TEXT)');
        },
        version: _version
      );
    }
    return _db;
  }

  Future insertMockData() async {
    _db
  }
}
