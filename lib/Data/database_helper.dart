import 'dart:io';
import 'package:e_commerce_app/Model/order_data.dart';
import 'package:e_commerce_app/Model/product.dart';
import 'package:e_commerce_app/Model/user.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;
  final String tableUser = "User";
  final String columnName = "name";
  final String columnUserName = "username";
  final String columnPassword = "password";
  final String columnType = "type";

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY, name TEXT, username TEXT, password TEXT, flaglogged TEXT,type TEXT NOT NULL)");
    await db.execute(
        "CREATE TABLE Product(id INTEGER PRIMARY KEY, name TEXT, price TEXT, category TEXT, description TEXT,image TEXT)");
    await db.execute(
        "CREATE TABLE Orders(id INTEGER PRIMARY KEY, name TEXT, price TEXT, clientname TEXT,city TEXT)");
    print("Table is created");
  }
  

  //insertion
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    print(user.name);
    int res = await dbClient.insert("User", user.toMap());
    List<Map> list = await dbClient.rawQuery('SELECT * FROM User');
    print(list);
    return res;
  }
  Future<List<Map>> selectUserType(User user) async {
    var dbClient = await db;
    print(user.type);
    List<Map> list = await dbClient.rawQuery('SELECT type FROM User where $columnUserName = ? and $columnPassword = ?',[user.username,user.password]);
    print(list.toString());
    return list;
  }

  //deletion
  Future<int> deleteUser() async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }
  Future<User> selectUser(User user) async{
    print("Select User");
    print(user.username);
    print(user.password);
    
    var dbClient = await db;
    List<Map> maps = await dbClient.query(tableUser,
        columns: [columnUserName, columnPassword,columnType],
        where: "$columnUserName = ? and $columnPassword = ?",
        whereArgs: [user.username,user.password]);
    print("User Info:");
    print(maps);
    if (maps.length > 0) {
      print("User Exist !!!");
      return user;
    }else {
      return null;
    }
  }

   Future<int> saveProduct(Product product) async {
    var dbClient = await db;
    print(product.name);
    int res = await dbClient.insert("Product", product.toMap());
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Product');
    print(list);
    return res;
  }
 
  Future<List<Product>> getPhotos() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query("Product", columns: ["id", "image"]);
    List<Product> photos = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        photos.add(Product.map(maps[i]));
      }
    }
    print(maps);
    return photos;
  }
  saveOrders() async {
    var data = OrderData.getData;
    List<OrderData> _data = [];
    try {
      await _db.transaction((tx) async {
        for (var i = 0; i < data.length; i++) {
          print("Called insert ${i}");
          OrderData d = new OrderData();
          d.id = i + 1;
          d.productName = data[i]["ProductName"];
          d.price = data[i]["Price"];
          d.clientName = data[i]["ClientName"];
          d.city = data[i]["City"];
          try {
            var qry =
                'INSERT INTO Orders(name, price, clientname,city) VALUES("${d.productName}","${d.price}", "${d.clientName}","${d.city}")';
            var _res = await tx.rawInsert(qry);
          } catch (e) {
            print("ERRR >>>");
            print(e);
          }
          _data.add(d);
        }

      });
    } catch (e) {
      print("ERRR ## > ");
      print(e);
    }
  }
  Future<List> getAllRecords() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM Orders");

    return result.toList();
}
}
