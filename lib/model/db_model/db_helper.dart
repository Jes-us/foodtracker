import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:foodtracker/model/db_model/prodf_model.dart';

class Databasehelper {
  static const _databaseName = "Alacena.db";
  static const _databaseVersion = 1;

  Databasehelper._();

  static final Databasehelper instance = Databasehelper._();
  static Database? _database;

  //Dinamyc values
  static const table = 'products';
  static const columnId = 'id';
  static const columnUpc = 'upc';
  static const columnBrand = 'brand';
  static const columnImage = 'image';
  static const columnDescription = 'description';
  static const columnTittle = 'tittle';
  static const productModel = 'productmodel';
  static const expirationDate = 'expirationdate';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _init();

    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _init() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table ($columnId INTEGER PRIMARY KEY AUTOINCREMENT ,$productModel TEXT,$expirationDate TEXT,$columnUpc  TEXT,$columnImage TEXT ,$columnBrand TEXT ,$columnDescription TEXT ,$columnTittle TEXT)');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Prodf row) async {
    final db = await database;
    return await db.insert(table, row.toJson());
  }

// All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.

  Future<List<Prodf>> queryAllRows() async {
    final db = await database;
    List<Map<String, Object?>> respDB = await db.query(table);
    return respDB.map((e) => Prodf.fromJson(e)).toList();
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    final db = await database;
    final results = await db.rawQuery('SELECT COUNT(*) FROM $table');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    int id = row[columnId];
    final db = await database;
    return await db.update(
      table,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int? id) async {
    final db = await database;
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
