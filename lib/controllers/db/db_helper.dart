import 'package:path/path.dart' as syspath;
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  DBHelper._privateConstructor();

  static final DBHelper instance = DBHelper._privateConstructor();
  static sql.Database? _database;

  Future<sql.Database> get database async => _database ??= await _initDB();

  static Future<sql.Database> _initDB() async {
    final dbPath = await sql.getDatabasesPath();

    return await sql.openDatabase(
      syspath.join(dbPath, 'my_wallet.db'),
      onCreate: onCreate,
      version: 1,
    );
  }

  static Future onCreate(sql.Database db, int version) async {
    await db.execute("""
      CREATE TABLE expenses(
        id PRIMARY KEY NOT NULL,
        title TEXT NOT NULL,
        dateTime     DATETIME NOT NULL,
        amount REAL NOT NULL,
        price REAL NOT NULL,
        iconData INT NOT NULL,
        iconFont TEXT NOT NULL,
        iconPackage TEXT NOT NULL
        );""");

    await db.execute("""
      CREATE TABLE budgets(
        id PRIMARY KEY NOT NULL,
        amount REAL NOT NULL,
        dateTime DATETIME NOT NULL
        );""");
  }
}
