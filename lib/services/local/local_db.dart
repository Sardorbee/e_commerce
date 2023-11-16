// ignore: depend_on_referenced_packages
import 'package:e_commerce/services/models/my_cart_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();

  LocalDatabase._init();

  factory LocalDatabase() {
    return getInstance;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("user_addresses.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const doubleType = "REAL DEFAULT 0.0";

    await db.execute('''
    CREATE TABLE ${MyCartModelFields.orderCartTable}(
    ${MyCartModelFields.id} $idType,
    ${MyCartModelFields.price} $textType,
    ${MyCartModelFields.orderName} $textType,
    ${MyCartModelFields.createdAt} $textType,
    ${MyCartModelFields.originalPrice} $textType,
    ${MyCartModelFields.quantity} $textType
    );
    ''');
  }

////////////////////////////////////////////////////////////////////////////////
  //! Orders Table
  static Future<MyCartModel> insertOrder(MyCartModel drinkModel) async {
    final db = await getInstance.database;
    final int id =
        await db.insert(MyCartModelFields.orderCartTable, drinkModel.toJson());
    return drinkModel.copyWith(id: id);
  }

  static Future<void> updateOrderPrice(
      {required int orderId,
      required String newPrice,
      required String newQuantity}) async {
    final db = await getInstance.database;

    await db.update(
      MyCartModelFields.orderCartTable,
      {
        MyCartModelFields.price: newPrice,
        MyCartModelFields.quantity: newQuantity,
      },
      where: "${MyCartModelFields.id} = ?",
      whereArgs: [orderId],
    );
  }

  static Future<List<MyCartModel>> getAllOrders() async {
    List<MyCartModel> allLocationUser = [];
    final db = await getInstance.database;
    allLocationUser = (await db.query(MyCartModelFields.orderCartTable))
        .map((e) => MyCartModel.fromJson(e))
        .toList();

    return allLocationUser;
  }

  static deleteOrderByID(int id) async {
    final db = await getInstance.database;
    db.delete(
      MyCartModelFields.orderCartTable,
      where: "${MyCartModelFields.id} = ?",
      whereArgs: [id],
    );
  }

  static deleteAllOrders() async {
    final db = await getInstance.database;
    db.delete(
      MyCartModelFields.orderCartTable,
    );
  }
}
